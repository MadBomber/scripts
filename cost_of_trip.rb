#!/usr/bin/env ruby
# cost_of_trip.rb

require 'debug_me'  # A tool to print the labeled value of variables.
include DebugMe
DebugMeDefaultOptions.merge!( {tag: "\r", header: false, time: false} )

total_miles       = 2500.0
miles_per_gallon  = 13.0
gallons_per_tank  = 18.0
miles_per_tank    = miles_per_gallon * gallons_per_tank

dollars_per_gallon= 2.35 # dollars

miles_per_day     = 400.0
days_on_the_road  = total_miles / miles_per_day
total_days        = 1.5 * days_on_the_road

price_of_hotel    = 250.0
cost_of_hotels    = total_days * price_of_hotel


total_attractions   = 4
total_people        = 4
price_per_attraction_person = 75.0
cost_of_attractions = total_attractions * total_people * price_per_attraction_person



cost_of_gas = total_miles / miles_per_gallon * dollars_per_gallon

miles_per_tank    = miles_per_gallon * gallons_per_tank

tanks_per_trip    = total_miles / miles_per_tank

cost_of_road_snaks = tanks_per_trip * 15.0


variables = (local_variables - [:variables, :expense_variables, :total_cost]).reject{|v| v.to_s.start_with? 'cost'}

puts
puts

variables.each do |var|
  debug_me{var}
end


expense_variables = local_variables.select{|v| v.to_s.start_with? 'cost'}

puts
puts

total_cost = 0.0
expense_variables.each do |cost|
  debug_me{cost}
  total_cost += eval(cost.to_s)
end

puts
puts
debug_me{:total_cost}


