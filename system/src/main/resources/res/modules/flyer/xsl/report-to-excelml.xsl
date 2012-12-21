<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
        xmlns="http://Radigan.org/Rapid-X/Report/Data/1.0"
        xmlns:r="http://Radigan.org/Rapid-X/Report/Data/1.0"
        xmlns:dp="urn:schemas-microsoft-com:office:office"
	xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">


<xsl:template match="/">
    <xsl:apply-templates select="r:report"/>
</xsl:template>

<xsl:template match="r:report">
    <xsl:processing-instruction name="mso-application">
      <xsl:text>progid="Excel.Sheet"</xsl:text>
    </xsl:processing-instruction>
    <ss:Workbook>
        <dp:DocumentProperties>
         <dp:Title><xsl:value-of select="r:metadata/r:report-name"/></dp:Title>
         <dp:Author><xsl:value-of select="r:metadata/r:author"/></dp:Author>
         <dp:LastAuthor><xsl:value-of select="r:metadata/r:author"/></dp:LastAuthor>
         <dp:Created>2007-07-22T09:11:45Z</dp:Created>
         <dp:LastSaved>2007-07-22T09:12:22Z</dp:LastSaved>
         <dp:Version><xsl:value-of select="r:metadata/r:version"/></dp:Version>
        </dp:DocumentProperties>
        <ss:Styles>
           <ss:Style ss:ID="Default" ss:Name="Normal">
            <ss:Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>
           </ss:Style>
           <ss:Style ss:ID="ReportHeader">
            <ss:Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>
            <ss:Font ss:Bold="1"/>
           </ss:Style>
           <ss:Style ss:ID="ColumnHeader">
            <ss:Interior ss:Color="#C0C0C0" ss:Pattern="Solid"/>
            <ss:Font ss:Bold="1"/>
           </ss:Style>
           <ss:Style ss:ID="GroupHeader">
            <ss:Interior ss:Color="#99CDFF" ss:Pattern="Solid"/>
            <ss:Font ss:Bold="1"/>
           </ss:Style>
           <ss:Style ss:ID="Record1">
            <ss:Interior ss:Color="#FFFFCC" ss:Pattern="Solid"/>
            <ss:Font ss:Bold="1"/>
           </ss:Style>
           <ss:Style ss:ID="Record2">
            <ss:Interior ss:Color="#FFCC99" ss:Pattern="Solid"/>
            <ss:Font ss:Bold="1"/>
           </ss:Style>
           <ss:Style ss:ID="ReportHeaderHyperlink">
             <ss:Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>
             <ss:Font ss:Color="#0000FF" ss:Underline="Single" ss:Bold="1"/>
           </ss:Style>
           <ss:Style ss:ID="1">
              <ss:Font ss:Bold="1"/>
           </ss:Style>
        </ss:Styles>
        <ss:Worksheet>
          <xsl:attribute name="ss:Name"><xsl:value-of select="r:metadata/r:report-name"/></xsl:attribute>
          <ss:Table>
            <xsl:for-each select="r:metadata/r:header/r:column">
              <ss:Column>
                <xsl:attribute name="ss:Width"><xsl:value-of select="@width"/></xsl:attribute>
              </ss:Column>
            </xsl:for-each>

            <ss:Row ss:StyleID="ReportHeaderHyperlink">
                <ss:Cell ss:HRef="http://www.YoungChampionsOfAmerica.com"><ss:Data ss:Type="String">Young Champions Of America (YCOA)</ss:Data></ss:Cell>
            </ss:Row>
            <ss:Row ss:StyleID="ReportHeader">
                <ss:Cell><ss:Data ss:Type="String"><xsl:value-of select="r:metadata/r:report-name"/> [v<xsl:value-of select="r:metadata/r:version"/>] - <xsl:value-of select="r:metadata/r:description-terse"/></ss:Data></ss:Cell>
            </ss:Row>
            <ss:Row ss:StyleID="ReportHeader">
                <ss:Cell><ss:Data ss:Type="String"></ss:Data></ss:Cell>
            </ss:Row>

            <ss:Row ss:StyleID="ColumnHeader">
              <xsl:for-each select="r:metadata/r:header/r:column">
                <ss:Cell><ss:Data ss:Type="String"><xsl:value-of select="@name"/></ss:Data></ss:Cell>
              </xsl:for-each>
            </ss:Row>
            <xsl:apply-templates select="r:data/r:group"/>
            <xsl:apply-templates select="r:data/r:record"/>
          </ss:Table>
        </ss:Worksheet>
    </ss:Workbook>
</xsl:template>

<xsl:template match="r:group">
    <ss:Row ss:StyleID="GroupHeader">
      <xsl:for-each select="ancestor::r:group">
        <ss:Cell><ss:Data ss:Type="String"></ss:Data></ss:Cell>
      </xsl:for-each>
      <ss:Cell>
        <ss:Data><xsl:attribute name="ss:Type"><xsl:value-of select="@type"/></xsl:attribute><xsl:value-of select="@value"/></ss:Data>
      </ss:Cell>
    </ss:Row>
    <xsl:apply-templates select="r:group"/>
    <xsl:apply-templates select="r:record"/>
</xsl:template>

<xsl:template match="r:record">
    <ss:Row>
      <xsl:attribute name="ss:StyleID">
        <xsl:if test="position() mod 2 = 1">Record1</xsl:if>
        <xsl:if test="position() mod 2 = 0">Record2</xsl:if>
      </xsl:attribute>
      <xsl:for-each select="ancestor::r:group">
        <ss:Cell><ss:Data ss:Type="String"></ss:Data></ss:Cell>
      </xsl:for-each>
      <xsl:apply-templates select="r:field"/>
    </ss:Row>
</xsl:template>

<xsl:template match="r:field">
    <ss:Cell>
      <ss:Data>
        <xsl:attribute name="ss:Type"><xsl:value-of select="@type"/></xsl:attribute>
        <xsl:value-of select="text()"/>
      </ss:Data>
    </ss:Cell>
</xsl:template>

</xsl:stylesheet>


