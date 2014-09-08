require 'geek_painter'
master_piece = GeekPainter.paint do
  label "[".in(:black).on :white
  label "\\u".in  :red
  label ":".in    :yellow
  label "\\h".in  :red
  label "] ".in(:bkacj).on :white
  label "\\W ".in :default
  label "\$(__git_ps1)".in :yellow # <= This might not work if you don't have git installed
end

puts master_piece.prompt

