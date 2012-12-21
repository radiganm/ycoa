<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
<xsl:output method="html"/>

  <xsl:template match="/root">
    <html>
     <tr valign="top" height="100%">
      <td>
       <table width="660" valign="top" align="center" frame="box">
        <tr>
         <td>
          <table width="660" border="0" cellspacing="0" cellpadding="0">
            <tr align="left" class="TableHeader">
              <td width="10">&#160;</td>
              <td width="80"><strong>Flyer ID</strong>&#160;</td>
              <td width="80"><strong>Flyer Name</strong>&#160;</td>
              <td width="250"><strong>Sizing</strong>&#160;</td>
              <td width="80"><strong># Classes</strong>&#160;</td>
              <td width="80"><strong># Schools</strong>&#160;</td>
            </tr>
            <xsl:for-each select="Flyer">
              <tr height="18" valign="top">
                <xsl:attribute name="class">shaded<xsl:value-of select="position() mod 2"/></xsl:attribute>
                <td>&#160;</td>
                <td>
                 <a>
                   <xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=<xsl:value-of select="FlyerClass/@ClassCount"/></xsl:attribute>
                   <xsl:value-of select="@FlyerID"/>&#160;
                 </a>
                </td>
                <td>
                 <a>
                   <xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=<xsl:value-of select="FlyerClass/@ClassCount"/></xsl:attribute>
                   <xsl:value-of select="FlyerClass/@FlyerName"/>&#160;
                 </a>
                </td>

                <td>
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=<xsl:value-of select="FlyerClass/@ClassCount"/></xsl:attribute>auto</a>&#160; |
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=1</xsl:attribute>1</a>&#160; |
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=2</xsl:attribute>2</a>&#160; |
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=3</xsl:attribute>3</a>&#160; |
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=4</xsl:attribute>4</a>&#160; |
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=5</xsl:attribute>5</a>&#160; |
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=6</xsl:attribute>6</a>&#160; |
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=7</xsl:attribute>7</a>&#160; |
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=8</xsl:attribute>8</a>&#160; |
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=9</xsl:attribute>9</a>&#160; |
                 <a><xsl:attribute name="href">flyer.glet?flyerid=<xsl:value-of select="@FlyerID"/>&amp;flyername=<xsl:value-of select="FlyerClass/@FlyerName"/>&amp;size=10</xsl:attribute>10</a>&#160; |
                </td>


                <td><xsl:value-of select="FlyerClass/@ClassCount"/>&#160;</td>
                <td><xsl:value-of select="FlyerClass/@SchoolCount"/>&#160;</td>
              </tr>
            </xsl:for-each>
          </table>
         </td>
        </tr>
       </table>
      </td>
     </tr>
    </html>
  </xsl:template> 

</xsl:stylesheet>

