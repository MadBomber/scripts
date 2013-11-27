#!/usr/bin/env ruby
##########################################################
###
##  File: magic_8_ball.rb
##  Desc: A plaything that uses the original 20 answers from the 1950s
##  By:   Dewayne VanHoozer (dvanhoozer@gmail.com)
#

answers = [
  "It is certain",
  "It is decidedly so",
  "Without a doubt",
  "Yes definitely",
  "You may rely on it",
  "As I see it yes",
  "Most likely",
  "Outlook good",
  "Yes",
  "Signs point to yes",
  "Reply hazy try again",
  "Ask again later",
  "Better not tell you now",
  "Cannot predict now",
  "Concentrate and ask again",
  "Don't count on it",
  "My reply is no",
  "My sources say no",
  "Outlook not so good",
  "Very doubtful"
]



######################################################
# Local methods

def get_answer(answers)
  return answers[rand(answers.length)]
end

def say_answer(answers)
  system "say '#{get_answer(answers)}'"
end

######################################################
# Main

say_answer(answers)


exit




