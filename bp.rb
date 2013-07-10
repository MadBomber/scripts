#!/usr/bin/env ruby
################################################
###
## 	File: bp.rb
##  Desc: Extract bp data from eMail and format into report
#

require 'pathname'
require 'awesome_print'
require 'date'

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

	puts <<EOS

Usage: np.rb file_path

Where: file_path is a path to a file of eMail messages

EOS

	exit(-1)
end

email_path = Pathname.new ARGV.first

unless email_path.exist?

	puts <<EOS

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

end

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

end

out_hash.sort.each do |entry|

	print "\n#{entry.first}"

 	entry.last.sort.each do |e|
 		print "  #{e.first[0,5]}  #{e.last}"
 	end

end

puts; puts

#################################################
## Draw a graph

require 'gruff'
require 'linefit'


def generate_plot( title, data_points, filter, *names )

	line_fit 		= LineFit.new
	line_fit2 	= LineFit.new

	x_labels	= Hash.new
	x_values 	= Array.new
	y_values 	= Array.new

	names.size.times do |x|
		y_values[x]	= Array.new
	end

	e_no = 0

	data_points.each do |entry|
		if filter.call(entry.first)
			x_labels[e_no]  = entry.first.strftime('%a')[0,1].downcase
			x_values 			 << e_no
			e_no += 1
			names.size.times do |x|
				m = names[x]
				y_values[x]	<< entry.last.send(m)
			end
		end
	end

	line_fit.setData( x_values,  y_values[0] )
	line_fit2.setData( x_values, y_values[1] )

	y_values[names.size] 	 = Array.new
	y_values[names.size+1] = Array.new


	x_values.each do |x|
		y_values[names.size] 	 << line_fit.forecast(x)
		y_values[names.size+1] << line_fit2.forecast(x)
	end

	g = Gruff::Line.new(800)
	g.title = "#{title}"

	g.theme = {
	  :colors => ['black', 'black', 'black', 'red', 'red'],
	  :marker_color 			=> 'black',
	  :font_color 				=> 'black',
	  :background_colors 	=> 'transparent'
	}

	g.labels = x_labels

	names.size.times do |x|
		g.data( names[x], y_values[x] )
	end

	g.data( :trend,  y_values[names.size] )
	g.data( :trend2, y_values[names.size+1] )


	g.write("#{title.downcase.gsub(' ','_')}.png")

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


generate_plot( 'BP History Evening', 
								my_data, 
								evening,
								:systolic, :diastolic, :rate
							) 





