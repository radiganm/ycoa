<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- system:       Rapid Prototype Flyer Processor (RPFP) -->
<!-- file:         default-page.xsl -->
<!-- author:       mac@radigan.org  -->
<!-- purpose:      format the RPPCP default page -->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:ycoa="http://radigan.org/ycoa/private/1.0">

  <xsl:param name="market"/>

  <xsl:output method="html" indent="yes"/>

  <xsl:template match="dataset">
    <html>
     <head>
      <title>RPPCP Index Page</title>
     </head>
     <body>
      <h2>Rapid Prototype Postcard Processor (RPPCP)</h2>
      <hr/>

      <h3>Developer Downloads</h3>
      schema (.xsd/.xml)<br/>
      seed (.seed/.xml)<br/>
      template (.template/.xml)<br/>
      <table cellpadding="2">
        <th align="left">Subreport</th>
        <th align="left">Schema</th>
        <th align="left">Seed</th>
        <th align="left">Template</th>
        <tr>
          <td>Outline</td>
          <td>postcard-outline.xsd.xml</td>
          <td>postcard-outline.seed.xml</td>
          <td>postcard-outline.template.xml</td>
        </tr>
        <tr>
          <td>Column</td>
          <td>postcard-panel.xsd.xml</td>
          <td>postcard-panel.seed.xml</td>
          <td>postcard-panel.template.xml</td>
        </tr>
      </table>
      <hr/>
      <h3>WORD ML Downloads</h3>
      wordml (.wordml/.xml)<br/>
      <table cellpadding="2">
        <th align="left">Semester</th>
        <th align="left">Year</th>
        <th align="left">Download</th>
        <xsl:for-each select="Class">
          <!--xsl:sort select="@fyYear"/-->
          <!--xsl:sort select="@fyID"/-->
          <!--xsl:sort select="@fySession"/-->
          <tr>
            <td><xsl:value-of select="@clYear"/></td>
            <td><xsl:value-of select="@clSemester"/></td>
            <td>
              <a><xsl:attribute name="href"><xsl:value-of select="@clYear"/>_<xsl:value-of select="@clSemester"/>.wordml.xml?cmd=report&amp;year=<xsl:value-of select="@clYear"/>&amp;semester=<xsl:value-of select="@clSemester"/>&amp;report=outline&amp;market=<xsl:value-of select="$market"/></xsl:attribute>postcards</a>
            </td>

          </tr>

        </xsl:for-each>
       </table>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="Flyer">
  </xsl:template>

</xsl:stylesheet>



