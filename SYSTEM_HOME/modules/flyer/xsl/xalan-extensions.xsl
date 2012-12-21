   <xsl:stylesheet version="2.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:xalan="http://xml.apache.org/xalan"
      xmlns:counter="MyCounter"
      extension-element-prefixes="counter">
                

   <xsl:output method="html"/>
   <xsl:variable name="line" select="1"/>
   <xsl:variable name="indent-increment" select="'   '" />

  <xalan:component prefix="counter"
                   elements="init incr" functions="read">
    <xalan:script lang="javascript">
      var counters = new Array();

      function init (xslproc, elem) {
        name = elem.getAttribute ("name");
        value = parseInt(elem.getAttribute ("value"));
        counters[name] = value;
        return null;
      }

      function read (name) {
        // Return a string.
        return "" + (counters[name]);
      }

      function incr (xslproc, elem)
      {
        name = elem.getAttribute ("name");
        counters[name]++;
        return null;
      }
    </xalan:script>
  </xalan:component>


   <xsl:template match="/">
     <html>
      <counter:init name="index" value="1"/>
      <xsl:apply-templates>
        <xsl:with-param name="indent" select="$indent-increment"/>
      </xsl:apply-templates>
     </html>
   </xsl:template>

   <xsl:template match="node()">
      <xsl:param name="indent" select="'&#xA;'"/>
      <xsl:variable name="line"><xsl:value-of select="$line+1"/></xsl:variable>
      <xsl:value-of select="$line"/>
      <xsl:value-of select="$indent"/>
      <counter:incr name="index"/>
      <xsl:value-of select="counter:read('index')"/>
      <xsl:copy/>
      <xsl:apply-templates>
        <xsl:with-param name="indent" select="concat($indent, $indent-increment)"/>
      </xsl:apply-templates>
   </xsl:template>

   <xsl:template match="comment()|processing-instruction()">
      <xsl:copy />
   </xsl:template>

</xsl:stylesheet>
