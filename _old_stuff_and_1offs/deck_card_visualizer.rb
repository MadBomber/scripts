#!/usr/bin/env ruby
########################################
###
## File: deck_card_visualizer.rb
##  Desc: Visualize where a card is located within a deck
#
# This program is a one-off that was used to verify
# the positional elements of a decksterJS project.
#

require 'pathname'
require 'json'
require 'amazing_print'

require 'debug_me'
include DebugMe

row_max = 10
col_max = 10

def position(h)
  result = "\t(RC:#{h['row']},#{h['col']} SizeYX: #{h['size_y']},#{h['size_x']}  ExpYX: #{h['expanded_y']},#{h['expanded_x']})"

  unless h['expanded_x'].nil?
    if (h['size_y'] > h['expanded_y'])  ||
       (h['size_x'] > h['expanded_x'])
      result += "  EXPANSION SIZE ERROR"
    end
  end

  return result
end

def space(my_space)
  my_space.shift
  puts
  print "COL:"
  my_space.first.size.times do |xx|
    x1 = xx+1
    printf "%d", x1%10
  end
  puts '(x)'

  print "ROW+"; print "-"*my_space.first.size; puts "+ "
  y1=1
  my_space.each do |row|
    printf "  %d",y1%10
    print '|'; print row[1,99]; print '|'
    printf "%d",y1%10
    puts
    y1+=1
  end
  print "(y)+"; print "-"*my_space.last.size; puts "+ "

  print "   "
  my_space.last.size.times do |xx|
    x1 = xx+1
    printf "%d", x1%10
  end
  puts
  puts

end

decks_path = Pathname.pwd + 'decks'
cards_path = Pathname.pwd + 'cards'

decks_path.children.each do |deck_path|
  puts "Deck: " + deck_path.basename.to_s
  a_deck = JSON.load(deck_path.read)

  deck_space = Array.new
  row_max.times.each do |row|
    deck_space[row] = " "*col_max
  end

  card_number = 0
  a_deck['cards'].each do |card_basename|
    card_number += 1
    print "#{card_number}) #{card_basename}  "
    card_path = cards_path + "#{card_basename}.json"
    a_card = JSON.load(card_path.read)
    puts position(a_card['position'])
    # ap a_card['position']
    pos = a_card['position']
    row    = pos['row']
    col    = pos['col']
    size_x = pos['size_x']
    size_y = pos['size_y']

    vert_range = (row..(row+size_y-1))
    horz_range = (col..(col+size_x-1))
    vert_size  = vert_range.size
    horz_size  = horz_range.size

    # puts "   V:#{vert_range}(#{vert_size})" +
    #      "   H:#{horz_range}(#{horz_size})"

    horz_occupied = "#{card_number}"*horz_size

    vert_range.each do |row|
      unless ''==deck_space[row][horz_range].strip
        puts "\nCARD OVERLAP ERROR at row #{row} col #{horz_range}"
        puts "  #{deck_space[row][horz_range]}"
        puts "  #{horz_occupied}"
      end
      deck_space[row][horz_range] = horz_occupied
    end

  end

  space(deck_space)

end

