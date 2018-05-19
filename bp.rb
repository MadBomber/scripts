#!/usr/bin/env ruby
################################################
###
## 	File: bp.rb
##  Desc: Extract bp data from eMail and format into report
#

require 'pathname'
require 'awesome_print'
require 'date'
require 'debug_me'
include DebugMe

class BloodPressureMeasurement

	attr_accessor :systolic
	attr_accessor :diastolic
	attr_accessor :rate

	def initialize( systolic, diastolic, rate  )
		@systolic 	= systolic
		@diastolic 	= diastolic
		@rate 			= rate
	end

	def to_s
		"#{@systolic} / #{@diastolic} @#{@rate}"
	end
end	# of class BloodPressureMeasurement


class String
	def to_bpm
		BloodPressureMeasurement.new( self[0,3].to_i, self[4,3].to_i, self[-2,2].to_i )
	end
end # end of class String


if ARGV.empty? or '-h' == ARGV.first or '--help' == ARGV.first

	puts <<~EOS

		Usage: np.rb file_path

		Where: file_path is a path to a file of eMail messages

	EOS

	exit(-1)
end

email_path = Pathname.new ARGV.first

unless email_path.exist?

	puts <<~EOS

		ERROR: File does not exist.
		       #{email_path}

	EOS

	exit(-1)
end

observations 	= Hash.new
datetime 			= nil

email_path.readlines.each do |a_line|

	a_line.chomp!.strip!

	if a_line.start_with?('Date')
		datetime = DateTime.parse(a_line[6,99])	# strings index at zero, 7th character begins the data string
		observations[datetime] = nil
	end

	if 100 < a_line[0,3].to_i
		observations[datetime] = a_line.to_bpm
	end
end # email_path.readlines.each do |a_line|

out_hash = Hash.new

observations.each_pair do |k,v|

	dow = k.strftime('%a')

	o_date, o_time = k.to_time.to_s.split(' ')

	key = "#{o_date} #{dow}"

	if out_hash.include?(key)
		out_hash[key] <<  [o_time, v]
	else
		out_hash[key] = [ [o_time, v] ]
	end
end # observations.each_pair do |k,v|

out_hash.sort.each do |entry|

	print "\n#{entry.first}"

 	entry.last.sort.each do |e|
 		print "  #{e.first[0,5]}  #{e.last}"
 	end
end # out_hash.sort.each do |entry|

print "\n\n"

#################################################
## Draw a graph

require 'daru'
require 'daru/plotly'
include Daru::Plotly::Methods

require 'linefit'


# title:string  			The plot title
# data_points:array 	and array of [x,y] entries where x is data-time, y is BloodPressureMeasurement
# filter:proc 				used to filter data_points
# names:array 				array of symbols used to extract data from BloodPressureMeasurement
def generate_plot( title, data_points, filter, *names )

	debug_me{[ :title, :names ]}

	line_fit 		= LineFit.new
	line_fit2 	= LineFit.new

	x_labels	= Hash.new
	x_values 	= Array.new
	y_values 	= Hash.new

	names.each do |series_name|
		y_values[series_name]	= Array.new
	end

	e_no = 0

	data_points.each do |entry|
		a_date 	= entry.first
		x_value = ((a_date.year - 2000)*100.0 + a_date.yday.to_f + a_date.hour.to_f / 24.0).round(2)
		y_value = entry.last.send(names.first)

		if filter.call(a_date)
			x_labels[e_no]  = x_value # a_date.strftime('%a')[0,1].downcase
			x_values 			 << e_no # x_value
			e_no += 1

			names.each do |series_name|
				y_values[series_name]	<< entry.last.send(series_name)
			end
		end # if filter.call(a_date)
	end

	line_fit.setData( x_values,  y_values[names[0]] )
	line_fit2.setData( x_values, y_values[names[1]] )

	y_values[:trend] 	= Array.new
	y_values[:trend2] = Array.new


	x_values.each do |x|
		y_values[:trend] 	<< line_fit.forecast(x)
		y_values[:trend2] << line_fit2.forecast(x)
	end

	# TODO: replace data stuff with a data_frame from "daru"
	d8_index = Daru::DateTimeIndex.date_range(
											start: 	'2018-4-1',
											end: 		'2018-5-31',
											freq: 	'D'
										)

	values 			= y_values
	values[:x] 	= x_values

	cat_index 	= Daru::CategoricalIndex.new(x_values)
	data_frame 	= Daru::DataFrame.new(values, index: cat_index)



	puts data_frame.data

	graph = plot(
	  data_frame,
	  x: :x,
	  y: names+[:trend, :trend2],
	  layout: {
	    title: title,
	    xaxis: { title: 'DateTime' },
	    yaxis: { title: 'Measurement' }
	  },
	)

	graph.generate_html
end	# of def generate_plot( title, data_points, filter, *names )


everything = Proc.new do |d8_time|
	true
end

morning = Proc.new do |d8_time|
	d8_time.hour <= 12
end

evening = Proc.new do |d8_time|
	d8_time.hour >= 19
end

# observations is a hash, turn it into an sorted array

my_data = observations.sort

=begin
generate_plot( 'BP History',
								my_data,
								everything,
								:systolic, :diastolic, :rate
							)


generate_plot( 'BP History Morning',
								my_data,
								morning,
								:systolic, :diastolic, :rate
							)
=end

generate_plot( 'BP History Evening',
								my_data,
								evening,
								:systolic, :diastolic, :rate
							)
