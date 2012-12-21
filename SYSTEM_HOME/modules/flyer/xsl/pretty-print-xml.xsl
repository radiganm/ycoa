   <xsl:stylesheet version="2.0"
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xmlns:date="http://xml.apache.org/xalan/java/java.util.Date"
      xmlns:java_lang="http://xml.apache.org/xalan/java/java.lang"
      exclude-result-prefixes="date java_lang"
   >
                

   <xsl:output method="html"/>
   <xsl:variable name="line" select="1"/>
   <xsl:variable name="indent-increment" select="'   '" />

   <xsl:variable name="dateObject"
     select="date:new(
         java_lang:Math.max(1027695561000,1038695561000)
     )"/>

   <xsl:template match="/">
     <html>
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
      <!--xsl:value-of select="date:toString(date:new())"/-->
      <xsl:value-of select="date:getTime($dateObject)"/>
      <xsl:copy/>
      <xsl:apply-templates>
        <xsl:with-param name="indent" select="concat($indent, $indent-increment)"/>
      </xsl:apply-templates>
   </xsl:template>

   <xsl:template match="comment()|processing-instruction()">
      <xsl:copy />
   </xsl:template>

</xsl:stylesheet>
