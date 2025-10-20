#!/usr/bin/env ruby
# frozen_string_literal: true
# qfx_budget_maker.rb
# Takes a QFX file (Quicken Financial Exchange format) to create
# an initial budget.

require 'date'
require 'optparse'
require 'debug_me'

include DebugMe

##########################################################
# Transaction represents a single bank transaction from QFX
#
class Transaction
  attr_reader :amount, :total_payment, :category, :payee,
              :date, :memo, :trntype, :check_num,
              :recurring_payment

  def initialize(trntype:, dtposted:, trnamt:, name:, memo: nil, checknum: nil)
    @trntype = trntype
    @amount = parse_money(trnamt)
    @total_payment = @amount.abs
    @payee = clean_name(name)
    @memo = memo&.strip
    @check_num = checknum&.strip
    @date = parse_date(dtposted)

    # Use payee as the category
    @category = @payee

    # Detect recurring based on transaction patterns
    # Will be updated by analyzer
    @recurring_payment = false
  end

  def recurring_payment=(value)
    @recurring_payment = value
  end

  def month_key
    @date&.strftime('%Y-%m') || 'Unknown'
  end

  def year_month
    @date&.strftime('%B %Y') || 'Unknown'
  end

  private

  def parse_money(value)
    return 0.0 if value.nil? || value.to_s.empty?
    value.to_s.strip.to_f
  end

  def parse_date(value)
    return nil if value.nil? || value.to_s.empty?
    # QFX date format: YYYYMMDDHHMMSS
    date_str = value.to_s.strip[0..7] # Get YYYYMMDD part
    Date.strptime(date_str, '%Y%m%d')
  rescue ArgumentError
    nil
  end

  def clean_name(name)
    return 'Unknown' if name.nil? || name.empty?

    cleaned = name.strip

    # Remove common prefixes
    cleaned = cleaned.sub(/^External Withdrawal\s+/, '')
    cleaned = cleaned.sub(/^Point Of Sale Withdrawal\s+/, '')
    cleaned = cleaned.sub(/^Check\s+/, '')
    cleaned = cleaned.sub(/^Deposit Transfer from\s+/, 'Transfer from ')
    cleaned = cleaned.sub(/^ACH\s+(Debit|Credit)\s+/, '')

    # Truncate if too long (keep first part which is usually the merchant)
    cleaned.split(/\s{2,}/).first || cleaned
  end
end

##########################################################
# QFXParser parses QFX files and extracts transactions
#
class QFXParser
  def self.parse_file(filename)
    content = File.read(filename)
    parse_content(content)
  end

  def self.parse_content(content)
    transactions = []

    # Find all STMTTRN blocks
    content.scan(/<STMTTRN>(.*?)<\/STMTTRN>/m).each do |block|
      txn_data = parse_transaction_block(block[0])
      transactions << Transaction.new(**txn_data) if txn_data
    end

    transactions
  end

  def self.parse_transaction_block(block)
    data = {}

    # Extract fields
    data[:trntype] = extract_field(block, 'TRNTYPE')
    data[:dtposted] = extract_field(block, 'DTPOSTED')
    data[:trnamt] = extract_field(block, 'TRNAMT')
    data[:name] = extract_field(block, 'NAME')
    data[:memo] = extract_field(block, 'MEMO')
    data[:checknum] = extract_field(block, 'CHECKNUM')

    # Only return if we have essential fields
    data if data[:trntype] && data[:dtposted] && data[:trnamt] && data[:name]
  end

  def self.extract_field(block, field_name)
    match = block.match(/<#{field_name}>([^<\n]+)/i)
    match ? match[1].strip : nil
  end
end

##########################################################
# BudgetAnalyzer analyzes transactions and generates budgets
#
class BudgetAnalyzer
  attr_reader :transactions, :monthly_data, :category_data

  def initialize(transactions)
    @transactions = transactions
    @monthly_data = {}
    @category_data = {}
    analyze_transactions
    detect_recurring_payments
  end

  def analyze_transactions
    debug_me { [@transactions.size] }

    @transactions.each do |txn|
      # Skip credits (deposits)
      next if txn.amount >= 0

      month = txn.month_key
      category = txn.category

      # Monthly data
      @monthly_data[month] ||= { total: 0.0, categories: {}, recurring: 0.0, one_time: 0.0 }
      @monthly_data[month][:total] += txn.total_payment
      @monthly_data[month][:categories][category] ||= 0.0
      @monthly_data[month][:categories][category] += txn.total_payment

      # Category data across all months
      @category_data[category] ||= { total: 0.0, count: 0, recurring_count: 0, transactions: [] }
      @category_data[category][:total] += txn.total_payment
      @category_data[category][:count] += 1
      @category_data[category][:transactions] << txn
    end
  end

  def detect_recurring_payments
    # Mark transactions as recurring if:
    # 1. Same payee appears multiple times
    # 2. Amounts are consistent (within 10% variance)
    @category_data.each do |category, data|
      next if data[:count] < 2

      amounts = data[:transactions].map(&:total_payment)
      avg_amount = amounts.sum / amounts.size

      # Check if amounts are consistent
      consistent = amounts.all? do |amt|
        variance = ((amt - avg_amount).abs / avg_amount * 100)
        variance < 10
      end

      if consistent && data[:count] >= 2
        # Mark all transactions for this category as recurring
        data[:transactions].each { |txn| txn.recurring_payment = true }
        data[:recurring_count] = data[:count]
      end
    end

    # Update monthly recurring/one_time totals
    @monthly_data.each do |month, month_data|
      month_data[:recurring] = 0.0
      month_data[:one_time] = 0.0
    end

    @transactions.each do |txn|
      next if txn.amount >= 0

      month = txn.month_key
      if txn.recurring_payment
        @monthly_data[month][:recurring] += txn.total_payment
      else
        @monthly_data[month][:one_time] += txn.total_payment
      end
    end
  end

  def one_time_categories
    # Identify categories that appear only once (single payment, non-recurring)
    @category_data.select { |_category, data| data[:count] == 1 }.keys
  end

  def budget_categories
    # Categories to include in budget (exclude one-time misc expenses)
    one_time = one_time_categories
    @category_data.keys.reject { |cat| one_time.include?(cat) }
  end

  def monthly_averages
    return {} if @monthly_data.empty?

    num_months = @monthly_data.size
    debug_me { [num_months] }

    averages = {
      total: 0.0,
      recurring: 0.0,
      one_time: 0.0,
      categories: {}
    }

    @monthly_data.each do |_month, data|
      averages[:total] += data[:total]
      averages[:recurring] += data[:recurring]
      averages[:one_time] += data[:one_time]

      data[:categories].each do |category, amount|
        averages[:categories][category] ||= 0.0
        averages[:categories][category] += amount
      end
    end

    # Calculate averages
    averages[:total] /= num_months
    averages[:recurring] /= num_months
    averages[:one_time] /= num_months
    averages[:categories].transform_values! { |v| v / num_months }

    averages
  end

  def recurring_payments_baseline
    recurring_txns = @transactions.select(&:recurring_payment)
    baseline = {}

    recurring_txns.each do |txn|
      category = txn.category
      baseline[category] ||= { total: 0.0, count: 0, payees: [] }
      baseline[category][:total] += txn.total_payment
      baseline[category][:count] += 1
      baseline[category][:payees] << txn.payee unless baseline[category][:payees].include?(txn.payee)
    end

    # Calculate average per month
    num_months = @monthly_data.size
    baseline.each do |_category, data|
      data[:monthly_average] = data[:total] / num_months
    end

    baseline
  end

  def trend_analysis
    sorted_months = @monthly_data.keys.sort
    return {} if sorted_months.size < 2

    trends = {
      total_trend: calculate_trend(sorted_months, :total),
      category_trends: {}
    }

    # Category trends
    all_categories = @category_data.keys
    all_categories.each do |category|
      category_monthly = sorted_months.map do |month|
        @monthly_data[month][:categories][category] || 0.0
      end

      next if category_monthly.all?(&:zero?)

      avg = category_monthly.sum / category_monthly.size
      latest = category_monthly.last
      change = latest - avg

      trends[:category_trends][category] = {
        average: avg,
        latest: latest,
        change: change,
        percent_change: avg.zero? ? 0.0 : (change / avg * 100)
      }
    end

    trends
  end

  def spending_recommendations
    averages = monthly_averages
    trends = trend_analysis
    recommendations = []

    # Find categories with increasing trends (only if we have trend data)
    if trends[:category_trends]
      trends[:category_trends].each do |category, data|
        if data[:percent_change] > 20
          recommendations << {
            type: :warning,
            category: category,
            message: "#{category} spending increased #{data[:percent_change].round(1)}% above average"
          }
        end
      end
    end

    # Find high-spend categories
    top_categories = averages[:categories].sort_by { |_k, v| -v }.first(3)
    top_categories.each do |category, amount|
      pct = (amount / averages[:total] * 100).round(1)
      if pct > 25
        recommendations << {
          type: :info,
          category: category,
          message: "#{category} represents #{pct}% of monthly budget ($#{amount.round(2)})"
        }
      end
    end

    # Check recurring vs one-time ratio
    if averages[:total] > 0
      recurring_pct = (averages[:recurring] / averages[:total] * 100).round(1)
      recommendations << {
        type: :info,
        category: 'Overall',
        message: "#{recurring_pct}% of spending is recurring, #{(100 - recurring_pct).round(1)}% is discretionary"
      }
    end

    recommendations
  end

  private

  def calculate_trend(sorted_months, key)
    values = sorted_months.map { |m| @monthly_data[m][key] }
    return { direction: 'stable', change: 0.0 } if values.size < 2

    avg = values.sum / values.size
    latest = values.last
    change = latest - avg
    percent_change = avg.zero? ? 0.0 : (change / avg * 100)

    {
      direction: percent_change > 5 ? 'increasing' : (percent_change < -5 ? 'decreasing' : 'stable'),
      change: change,
      percent_change: percent_change
    }
  end
end

##########################################################
# BudgetReport generates output reports
#
class BudgetReport
  def initialize(analyzer)
    @analyzer = analyzer
  end

  def display_summary
    puts "\n" + "=" * 80
    puts "BUDGET ANALYSIS SUMMARY (QFX)"
    puts "=" * 80

    # Overall statistics
    puts "\nOVERALL STATISTICS:"
    puts "-" * 80
    averages = @analyzer.monthly_averages
    puts "Number of months analyzed: #{@analyzer.monthly_data.size}"
    puts "Total transactions: #{@analyzer.transactions.size}"
    puts "Average monthly spending: $#{averages[:total].round(2)}"
    puts "  Recurring: $#{averages[:recurring].round(2)} (#{(averages[:recurring] / averages[:total] * 100).round(1)}%)"
    puts "  One-time: $#{averages[:one_time].round(2)} (#{(averages[:one_time] / averages[:total] * 100).round(1)}%)"

    # Category breakdown
    puts "\nTOP SPENDING CATEGORIES (Monthly Average):"
    puts "-" * 80
    one_time_cats = @analyzer.one_time_categories
    averages[:categories].sort_by { |_k, v| -v }.first(10).each_with_index do |(category, amount), idx|
      pct = (amount / averages[:total] * 100).round(1)
      misc_marker = one_time_cats.include?(category) ? " [misc]" : ""
      puts "#{idx + 1}. #{category.ljust(30)} $#{amount.round(2).to_s.rjust(10)} (#{pct}%)#{misc_marker}"
    end

    # Recurring payments
    puts "\nRECURRING PAYMENTS BASELINE:"
    puts "-" * 80
    baseline = @analyzer.recurring_payments_baseline
    total_recurring = 0.0
    baseline.sort_by { |_k, v| -v[:monthly_average] }.each do |category, data|
      puts "#{category.ljust(30)} $#{data[:monthly_average].round(2).to_s.rjust(10)} (#{data[:count]} payments)"
      total_recurring += data[:monthly_average]
    end
    puts "#{'-' * 43} $#{total_recurring.round(2).to_s.rjust(10)}"

    # Trend analysis
    puts "\nTREND ANALYSIS:"
    puts "-" * 80
    trends = @analyzer.trend_analysis

    if trends.empty?
      puts "Not enough data for trend analysis (need at least 2 months)"
    else
      puts "Overall spending trend: #{trends[:total_trend][:direction]}"
      if trends[:total_trend][:percent_change].abs > 1
        puts "  Change: #{trends[:total_trend][:percent_change].round(1)}% vs average"
      end

      puts "\nCategory Trends (>10% change):"
      significant_trends = trends[:category_trends]
        .select { |_k, v| v[:percent_change].abs > 10 }
        .sort_by { |_k, v| -v[:percent_change].abs }

      if significant_trends.empty?
        puts "  No significant category trends detected"
      else
        significant_trends.each do |category, data|
          direction = data[:percent_change] > 0 ? "↑" : "↓"
          puts "  #{direction} #{category}: #{data[:percent_change].round(1)}% change"
        end
      end
    end

    # Recommendations
    puts "\nRECOMMENDATIONS:"
    puts "-" * 80
    @analyzer.spending_recommendations.each_with_index do |rec, idx|
      icon = rec[:type] == :warning ? "⚠" : "ℹ"
      puts "#{idx + 1}. #{icon}  #{rec[:message]}"
    end

    # One-time misc expenses
    one_time_cats = @analyzer.one_time_categories
    unless one_time_cats.empty?
      puts "\nONE-TIME MISC EXPENSES (excluded from budget):"
      puts "-" * 80
      one_time_total = 0.0
      one_time_cats.sort.each do |category|
        amount = @analyzer.category_data[category][:total]
        one_time_total += amount
        puts "#{category.ljust(40)} $#{amount.round(2).to_s.rjust(10)}"
      end
      puts "#{'-' * 43} $#{one_time_total.round(2).to_s.rjust(10)}"
    end

    # Projected budget (exclude one-time misc expenses)
    puts "\nPROJECTED MONTHLY BUDGET:"
    puts "-" * 80
    budget_cats = @analyzer.budget_categories
    budget_total = 0.0

    # Calculate budget total from recurring categories only
    budget_categories_with_amounts = averages[:categories]
      .select { |cat, _amount| budget_cats.include?(cat) }
      .sort_by { |_k, v| -v }

    budget_categories_with_amounts.each do |category, amount|
      puts "#{category.ljust(40)} $#{amount.round(2).to_s.rjust(10)}"
      budget_total += amount
    end
    puts "=" * 80
    puts "#{'TOTAL PROJECTED MONTHLY BUDGET'.ljust(40)} $#{budget_total.round(2).to_s.rjust(10)}"
    puts "=" * 80
    puts
  end
end

##########################################################
# Main program
#
def main
  options = {}

  OptionParser.new do |opts|
    opts.banner = "Usage: qfx_budget_maker.rb [options]"
    opts.on("-i", "--input FILE", "Input QFX file (required)") { |v| options[:input] = v }
    opts.on("-h", "--help", "Show this help message") do
      puts opts
      exit
    end
  end.parse!

  # Validate options
  if options[:input].nil?
    puts "Error: --input is required"
    puts "Usage: qfx_budget_maker.rb --input input.qfx"
    exit 1
  end

  unless File.exist?(options[:input])
    puts "Error: Input file '#{options[:input]}' not found"
    exit 1
  end

  debug_me { [options] }

  # Read transactions
  puts "Reading transactions from #{options[:input]}..."
  transactions = QFXParser.parse_file(options[:input])

  puts "Loaded #{transactions.size} transactions"

  # Analyze
  puts "Analyzing budget data..."
  analyzer = BudgetAnalyzer.new(transactions)

  # Display summary
  report = BudgetReport.new(analyzer)
  report.display_summary

  puts "Budget analysis complete!"
end

# Run the program
main if __FILE__ == $PROGRAM_NAME
