<?xml version="1.0" encoding="ISO-8859-1"?>
<!--?xml version="1.0" encoding="utf-8"?-->
<!-- dataset_to_reportdata.xsl -->
<!--
-->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:ycoa="http://radigan.org/ycoa/private/1.0">

<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>



