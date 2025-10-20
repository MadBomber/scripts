#!/usr/bin/env ruby

require 'csv'
require 'date'

if ARGV.empty?
  puts "Usage: ruby csv2qfx.rb <input.csv>"
  puts "Outputs <input>.qfx"
  exit 1
end

input_file = ARGV[0]
output_file = input_file.sub(/\.csv\z/i, '.qfx')

transactions = []

CSV.foreach(input_file) do |row|
  # Skip header row
  next if row[0] == 'Amount'

  # Use TotalPayment as amount (includes fee if present)
  total_str = row[2].to_s.strip.gsub(/[\$,]/, '')
  amount = total_str.to_f
  next if amount.zero?

  # Prefer DeliveryOn, fallback to Payment Date
  date_str = row[7].to_s.strip
  date_str = row[8].to_s.strip if date_str.empty?
  next if date_str.empty?

  begin
    dt = Date.strptime(date_str, '%m/%d/%Y')
    dt_posted = dt.strftime('%Y%m%d')
  rescue ArgumentError
    puts "Warning: Invalid date '#{date_str}' for transaction #{total_str}, skipping."
    next
  end

  trntype = 'CHECK'  # Assuming check payments based on samples

  fitid = row[15].to_s.strip
  fitid = "#{dt_posted}-#{total_str.gsub('-', '')}" if fitid.empty?

  name = row[6].to_s.strip

  # Build memo
  memo_parts = []
  category = row[3].to_s.strip
  memo_parts << category if !category.empty?
  payment_type = row[4].to_s.strip
  memo_parts << payment_type if !payment_type.empty?

  # Extract check number for REFNUM
  refnum = ''
  if payment_type =~ /Check#(\d+)/
    refnum = $1
  end

  memo = memo_parts.join(' ')

  # Add address if present
  addr_parts = [row[11], row[12], row[13], row[14]].map(&:to_s).map(&:strip).compact
  memo += " #{addr_parts.join(', ')}" if addr_parts.any?

  # Recurring
  recurring = row[16].to_s.strip.downcase == 'yes' ? ' (Recurring)' : ''
  memo += recurring

  transactions << {
    dt_posted: dt_posted,
    trntype: trntype,
    trnamt: amount,
    fitid: fitid,
    name: name,
    memo: memo.strip,
    refnum: refnum
  }
end

if transactions.empty?
  puts 'No valid transactions found.'
  exit 1
end

# Determine date range
parsed_dates = transactions.map { |t| Date.strptime(t[:dt_posted], '%Y%m%d') }
min_date = parsed_dates.min.strftime('%Y%m%d')
max_date = (parsed_dates.max + 1).strftime('%Y%m%d')

# Current server time
now = Time.now.strftime('%Y%m%d%H%M%S')
dt_asof = Time.now.strftime('%Y%m%d')

# Build XML
xml = <<~XML
  <?xml version="1.0" encoding="UTF-8" standalone="no"?>
  <?OFX OFXHEADER="200" VERSION="102" SECURITY="NONE" OLDFILEUID="NONE" NEWFILEUID="NONE"?>
  <OFX>
    <SIGNONMSGSRSV1>
      <SONRS>
        <STATUS>
          <CODE>0</CODE>
          <SEVERITY>INFO</SEVERITY>
        </STATUS>
        <DTSERVER>#{now}</DTSERVER>
        <LANGUAGE>ENG</LANGUAGE>
        <FI>
          <ORG>Manual Import</ORG>
          <FID>9999</FID>
        </FI>
      </SONRS>
    </SIGNONMSGSRSV1>
    <BANKMSGSRSV1>
      <BANKTRNRS>
        <TRNUID>IMPORT1</TRNUID>
        <STATUS>
          <CODE>0</CODE>
          <SEVERITY>INFO</SEVERITY>
        </STATUS>
        <STMTRS>
          <CURDEF>USD</CURDEF>
          <BANKACCTFROM>
            <BANKID></BANKID>
            <ACCTID>IMPORTED</ACCTID>
            <ACCTTYPE>CHECKING</ACCTTYPE>
          </BANKACCTFROM>
          <BANKTRANLIST>
            <DTSTART>#{min_date}</DTSTART>
            <DTEND>#{max_date}</DTEND>
XML

transactions.each do |t|
  refnum_xml = "<REFNUM>#{t[:refnum]}</REFNUM>" if !t[:refnum].empty?
  xml += <<~XML
              <STMTTRN>
                <TRNTYPE>#{t[:trntype]}</TRNTYPE>
                <DTPOSTED>#{t[:dt_posted]}</DTPOSTED>
                <TRNAMT>#{format('%.2f', t[:trnamt])}</TRNAMT>
                <FITID>#{t[:fitid]}</FITID>
                #{refnum_xml || ''}
                <NAME>#{t[:name]}</NAME>
                <MEMO>#{t[:memo]}</MEMO>
              </STMTTRN>
  XML
end

xml += <<~XML
          </BANKTRANLIST>
          <LEDGERBAL>
            <BALAMT>0.00</BALAMT>
            <DTASOF>#{dt_asof}</DTASOF>
          </LEDGERBAL>
        </STMTRS>
      </BANKTRNRS>
    </BANKMSGSRSV1>
  </OFX>
XML

File.write(output_file, xml)
puts "Successfully converted #{transactions.size} transactions to #{output_file}"
