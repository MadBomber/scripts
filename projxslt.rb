###########################################################
##  File:  projxslt.rb
##  Desc:  Used by ruby2html.rb
#

require 'xml/xslt'

class Projxslt

  def initialize(sxml, sxsl)
    @sxml = sxml
    @sxsl = sxsl
  end

  def transform(h=nil)
    begin
      xslt = XML::XSLT.new()
      xslt.xml = @sxml
      xslt.xsl = @sxsl

      if not h.nil? then xslt.parameters = h end
      out = xslt.serve()
      out

    rescue
      puts 'problem with xslt data'
    end
  end

end

if __FILE__ == $0
  h = Hash.new
  h["id"] = '1'
  puts h
  pxsl = Projxslt.new("../recordx/recordx.xml", "../xsl/recordx.xsl")
  puts pxsl.transform(h)
end
