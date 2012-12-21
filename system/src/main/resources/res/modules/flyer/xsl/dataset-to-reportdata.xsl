<?xml version="1.0" encoding="UTF-8"?>
<!-- dataset_to_reportdata.xsl -->
<!--
-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:ycoa="http://radigan.org/ycoa/private/1.0">

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

  <!--xsl:template match="/root"-->
  <xsl:template match="/root">
   <dataset>
    <xsl:apply-templates/>
   </dataset>
  </xsl:template>

  <!-- *** Match Security Token *** -->
  <!--xsl:template match="@st">
    <xsl:apply-templates select="@*"/>
    <xsl:element name="security-token">
      <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
    </xsl:element>
  </xsl:template-->

  <!-- *** Match Nodes *** -->
  <xsl:template match="node()">
    <xsl:element name="{name()}">
      <xsl:attribute name="type">table</xsl:attribute>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="*"/>
    </xsl:element>
  </xsl:template>

  <!-- *** Match Attributes *** -->
  <xsl:template match="@*">
    <xsl:element name="{name()}">
      <xsl:attribute name="type">field</xsl:attribute>
      <xsl:value-of select="."/>
      <xsl:apply-templates/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>



