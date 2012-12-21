<xsl:stylesheet version="2.0"
  xmlns:fo="dummy"
  xmlns:f="http://Radigan.org/Rapid-X/Report/FlatDataset/1.0"
  xmlns:d="http://Radigan.org/Rapid-X/Dataset/1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://Radigan.org/Rapid-X/Report/FlatDataset/1.0">

<!--+
    |
    |  @file:     dataset-to-flatdataset.xsl
    |  @author:   Mac Radigan
    |
    |  @purpose:  Convert a dataset into a flat dataset.
    |
    +-->

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:namespace-alias stylesheet-prefix="fo" result-prefix="f"/>

  <xsl:template match="/">
    <fo:dataset>
      <xsl:apply-templates select="d:dataset"/>
    </fo:dataset>
  </xsl:template>

  <xsl:template match="d:dataset">
    <xsl:for-each select="node()">
      <fo:record>
        <xsl:apply-templates select="node()"/>
      </fo:record>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="node()">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates select="node()"/>
  </xsl:template>

</xsl:stylesheet>

