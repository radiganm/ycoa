<xsl:stylesheet version="2.0"
  xmlns:f="http://Radigan.org/Rapid-X/Report/Format/1.0"
  xmlns:d="http://Radigan.org/Rapid-X/Dataset/1.0"
  xmlns:r="http://Radigan.org/Rapid-X/Report/Data/1.0"
  xmlns:ro="dummy1"
  xmlns:xslo="dummy2"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fn="http://www.w3.org/2005/02/xpath-functions"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns="http://Radigan.org/Rapid-X/Report/Format/1.0">


  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:namespace-alias stylesheet-prefix="xslo" result-prefix="xsl"/>
  <xsl:namespace-alias stylesheet-prefix="ro" result-prefix="r"/>

  <xsl:template match="/">
   <xslo:stylesheet version="2.0">

     <xslo:template match="/">
       <ro:report>
         <xslo:apply-templates select="d:dataset"/>
       </ro:report>
     </xslo:template>

     <xslo:template match="d:dataset">
       <xsl:apply-templates select="f:report-format"/>
     </xslo:template>

     <!--xslo:template match="*">
       <xslo:copy-of select="."/>
       <xslo:apply-templates select="node()|@*"/>
     </xslo:template-->

     <xslo:template match="node()">
       <xslo:element>
         <xsl:attribute name="name">r:{name()}</xsl:attribute>
         <xslo:attribute name="type">record</xslo:attribute>
         <xslo:apply-templates select="@*"/>
         <xslo:apply-templates select="*"/>
       </xslo:element>
     </xslo:template>

     <xslo:template match="@*">
       <xslo:element>
         <xsl:attribute name="name">r:{name()}</xsl:attribute>
         <xslo:attribute name="type">field</xslo:attribute>
         <xslo:value-of select="."/>
       </xslo:element>
     </xslo:template>

   </xslo:stylesheet>
  </xsl:template>

  <xsl:template match="f:report-format">
    <r:metadata>
      <xsl:apply-templates select="f:metadata"/>
    </r:metadata>
    <r:data>
      <xsl:apply-templates select="f:data"/>
    </r:data>
  </xsl:template>

  <xsl:template match="f:metadata">
    <xsl:apply-templates select="f:*"/>
  </xsl:template>

  <xsl:template match="f:report-name">
    <r:report-name><xsl:value-of select="text()"/></r:report-name>
  </xsl:template>

  <xsl:template match="f:author">
    <r:author><xsl:value-of select="text()"/></r:author>
  </xsl:template>

  <xsl:template match="f:modified">
    <r:modified><xsl:value-of select="text()"/></r:modified>
  </xsl:template>

  <xsl:template match="f:version">
    <r:version><xsl:value-of select="text()"/></r:version>
  </xsl:template>

  <xsl:template match="f:description-terse">
    <r:description-terse><xsl:value-of select="text()"/></r:description-terse>
  </xsl:template>

  <xsl:template match="f:description-verbose">
    <r:description-verbose><xsl:value-of select="text()"/></r:description-verbose>
  </xsl:template>

  <xsl:template match="f:data">
    <xsl:apply-templates select="f:group"/>
  </xsl:template>

  <xsl:template match="f:header">
    <r:header>
      <xsl:apply-templates select="f:column"/>
    </r:header>
  </xsl:template>

  <xsl:template match="f:column">
    <r:column>
      <xsl:attribute name="name"><xsl:apply-templates select="@name"/></xsl:attribute>
      <xsl:attribute name="width"><xsl:apply-templates select="@width"/></xsl:attribute>
    </r:column>
  </xsl:template>

  <xsl:template match="f:group">
      <xslo:for-each-group>
        <xsl:attribute name="select"><xsl:if test="parent::f:data">d:row</xsl:if><xsl:if test="not(parent::f:data)">current-group()</xsl:if></xsl:attribute>
        <xsl:attribute name="group-by">@<xsl:value-of select="@name"/></xsl:attribute>
        <xslo:element name="r:group">
          <xslo:attribute name="name"><xsl:value-of select="@name"/></xslo:attribute>
          <xslo:attribute name="value"><xslo:value-of select="current-grouping-key()"/></xslo:attribute>
          <xslo:attribute name="type"><xsl:value-of select="@type"/></xslo:attribute>
          <xsl:if test="child::f:field">
            <xslo:for-each select="current-group()">
              <r:record>
                <xsl:apply-templates select="f:field"/>
              </r:record>
            </xslo:for-each>
          </xsl:if>
          <xsl:if test="child::f:group">
            <xsl:apply-templates select="f:group"/>
          </xsl:if>
        </xslo:element>
      </xslo:for-each-group>
  </xsl:template>

  <xsl:template match="f:field">
      <xslo:element name="r:field">
        <xslo:attribute name="name"><xsl:value-of select="@name"/></xslo:attribute>
        <xslo:attribute name="type"><xsl:value-of select="@type"/></xslo:attribute>
        <xslo:value-of><xsl:attribute name="select">@<xsl:value-of select="@name"/></xsl:attribute></xslo:value-of>
      </xslo:element>
  </xsl:template>

</xsl:stylesheet>

