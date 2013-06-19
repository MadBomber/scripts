
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

  <xsl:output method="html" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
              encoding="ISO-8859-1"/> 

  <xsl:template match="/">
    <xsl:element name="html">

      <head>
        <title>Sample code</title>
        <link rel="stylesheet" type="text/css" href="ruby2html.css" />
      </head>

      <body>
        <div id="wrap">
          <xsl:apply-templates />
        </div>
      </body> 

    </xsl:element>
  </xsl:template>

  <xsl:template match="pre">
    <xsl:copy-of select="."/>
  </xsl:template>

</xsl:stylesheet>

