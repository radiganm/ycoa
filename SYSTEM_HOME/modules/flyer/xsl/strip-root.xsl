<?xml version="1.0" encoding="UTF-8"?>
<!-- strip-root.xsl -->
<!-- 
 ***************************************************************************************
 *
 * transform:   strip-root.xsl  
 * author:      Mac@Radigan.org
 *
 * module:      
 * description: 
 *
 ***************************************************************************************
 -->
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:datetime="urn:schemas-radigan-org:datetime"
  xmlns:string="urn:schemas-radigan-org:string"
  xmlns:cinclude="http://apache.org/cocoon/include/1.0"
  version="2.0">

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

<xsl:template match="/form">
  <xsl:copy-of select="node()"/>
</xsl:template>

</xsl:stylesheet>


