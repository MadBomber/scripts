#!/usr/bin/ruby
#####################################################
##  File:  ruby2html.rb
##  Desc:  converts ruby source code into html
#

require 'rubygems'
require 'syntax/convertors/html'
require 'projxslt' # <- this is my own class to do an XSLT transform
require 'rexml/document'
include REXML

class Ruby2Html
  def initialize(rubyfile, htmlfile)
    code = File.read(rubyfile)
    convertor = Syntax::Convertors::HTML.for_syntax "ruby"
    code_html = convertor.convert(code)

    tempfile = 'ruby2html.xml'
    xslfile = 'ruby2html.xsl'
    save_file(tempfile, code_html)

    px = Projxslt.new(tempfile, xslfile)
    buffer = px.transform()
    save_file(htmlfile, buffer)

  end

  def save_file(filename, buffer)
    file = File.new(filename, 'w')
    file.puts buffer
    file.close
  end
end

if __FILE__ == $0
  r2h = Ruby2Html.new('ruby2html.rb', 'ruby2html.html')
  puts 'completed'
end
