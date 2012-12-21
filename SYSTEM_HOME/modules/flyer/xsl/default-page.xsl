<?xml version="1.0" encoding="ISO-8859-1"?>
<!-- system:       Rapid Prototype Flyer Processor (RPFP) -->
<!-- file:         default-page.xsl -->
<!-- author:       mac@radigan.org  -->
<!-- purpose:      format the RPFP default page -->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:ycoa="http://radigan.org/ycoa/private/1.0">

  <xsl:param name="market"/>

  <xsl:output method="html" indent="yes"/>

  <xsl:template match="dataset">
    <html>
     <head>
      <title>RPFP Index Page</title>
     </head>
     <body>
      <h2>Rapid Prototype Flyer Processor (RPFP)</h2>
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
          <td>flyer-main.xsd.xml</td>
          <td>flyer-main.seed.xml</td>
          <td>flyer-main.template.xml</td>
        </tr>
        <tr>
          <td>Column</td>
          <td>flyer-columns.xsd.xml</td>
          <td>flyer-columns.seed.xml</td>
          <td>flyer-columns.template.xml</td>
        </tr>
        <tr>
          <td>Options</td>
          <td>flyer-options.xsd.xml</td>
          <td>flyer-options.seed.xml</td>
          <td>flyer-options.template.xml</td>
        </tr>
      </table>
      <hr/>
      <h3>WORD ML Downloads</h3>
      wordml (.wordml/.xml)<br/>
      <table cellpadding="2">
        <th align="left">ID</th>
        <th align="left">Name</th>
        <th align="left">Sports</th>
        <th align="left">Language</th>
        <th align="left">Semester</th>
        <th align="left">Year</th>
        <th align="left">Test (options)</th>
        <th align="left">Flyer!!!</th>
        <th align="left">Cover</th>
        <th align="left">Outline</th>
        <!--th align="left">Column</th-->
        <th align="left">Options (karate)</th>
        <th align="left">Options (cheer)</th>
        <th align="left">Options (soccer)</th>
        <th align="left">Options (hiphop)</th>
        <th align="left">Options (safe)</th>
        <xsl:for-each select="Flyer">
          <!--xsl:sort select="@fyYear"/-->
          <!--xsl:sort select="@fyID"/-->
          <!--xsl:sort select="@fySession"/-->
          <tr>
            <td><xsl:value-of select="@fyID"/></td>
            <td><xsl:value-of select="@fyName"/></td>
            <td><xsl:value-of select="@fyNumOfSport"/></td>
            <td>
               <xsl:if test="@fySpanEng='0'">English</xsl:if>
               <xsl:if test="@fySpanEng='1'">Spanish</xsl:if>
            </td>
            <td><xsl:value-of select="@fySession"/></td>
            <td><xsl:value-of select="@fyYear"/></td>

            <td>
             <xsl:if test="@HasKarate=1">
              <!--a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.r.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=1&amp;format=raw</xsl:attribute>R</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.x.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=1&amp;format=xsl</xsl:attribute>X</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.u.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=1&amp;format=xml</xsl:attribute>U</a-->
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.1.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=1</xsl:attribute>1</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.2.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=2</xsl:attribute>2</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.3.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=3</xsl:attribute>3</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.4.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=4</xsl:attribute>4</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.5.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=5</xsl:attribute>5</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.6.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=6</xsl:attribute>6</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.7.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=7</xsl:attribute>7</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.8.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=8</xsl:attribute>8</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.9.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=9</xsl:attribute>9</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=test&amp;sport=karate&amp;style=10</xsl:attribute>10</a>
             </xsl:if>
             <xsl:if test="@HasKarate!=1">N/A</xsl:if>
            </td>
            <td>
              <!--a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.r.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;format=raw&amp;market=<xsl:value-of select="$market"/></xsl:attribute>R</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.x.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;format=xsl&amp;market=<xsl:value-of select="$market"/></xsl:attribute>X</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.u.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;format=xml&amp;market=<xsl:value-of select="$market"/></xsl:attribute>U</a-->
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.1.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=1&amp;market=<xsl:value-of select="$market"/></xsl:attribute>1</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.2.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=2&amp;market=<xsl:value-of select="$market"/></xsl:attribute>2</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.3.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=3&amp;market=<xsl:value-of select="$market"/></xsl:attribute>3</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.4.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=4&amp;market=<xsl:value-of select="$market"/></xsl:attribute>4</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.5.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=5&amp;market=<xsl:value-of select="$market"/></xsl:attribute>5</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.6.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=6&amp;market=<xsl:value-of select="$market"/></xsl:attribute>6</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.7.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=7&amp;market=<xsl:value-of select="$market"/></xsl:attribute>7</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.8.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=8&amp;market=<xsl:value-of select="$market"/></xsl:attribute>8</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.9.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=9&amp;market=<xsl:value-of select="$market"/></xsl:attribute>9</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=10&amp;market=<xsl:value-of select="$market"/></xsl:attribute>10</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;market=<xsl:value-of select="$market"/></xsl:attribute>Auto</a>
            </td>
            <td>
              <!--a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.r.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;format=raw</xsl:attribute>R</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.x.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;format=xsl</xsl:attribute>X</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.u.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;format=xml</xsl:attribute>U</a-->
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.1.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;style=1</xsl:attribute>1</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.2.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;style=2</xsl:attribute>2</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.3.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;style=3</xsl:attribute>3</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.4.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;style=4</xsl:attribute>4</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.5.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;style=5</xsl:attribute>5</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.6.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;style=6</xsl:attribute>6</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.7.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;style=7</xsl:attribute>7</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.8.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;style=8</xsl:attribute>8</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.9.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;style=9</xsl:attribute>9</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=cover&amp;style=10</xsl:attribute>10</a>
            </td>
            <td>
              <!--a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.r.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;format=raw</xsl:attribute>R</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.x.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;format=xsl</xsl:attribute>X</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.u.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;format=xml</xsl:attribute>U</a-->
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.1.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=1</xsl:attribute>1</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.2.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=2</xsl:attribute>2</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.3.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=3</xsl:attribute>3</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.4.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=4</xsl:attribute>4</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.5.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=5</xsl:attribute>5</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.6.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=6</xsl:attribute>6</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.7.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=7</xsl:attribute>7</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.8.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=8</xsl:attribute>8</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.9.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=9</xsl:attribute>9</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=outline&amp;style=10</xsl:attribute>10</a>
            </td>
            <!--td>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.r.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;format=raw</xsl:attribute>R</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.x.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;format=xsl</xsl:attribute>X</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.u.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;format=xml</xsl:attribute>U</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.1.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;style=1</xsl:attribute>1</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.2.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;style=2</xsl:attribute>2</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.3.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;style=3</xsl:attribute>3</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.4.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;style=4</xsl:attribute>4</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.5.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;style=5</xsl:attribute>5</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.6.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;style=6</xsl:attribute>6</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.7.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;style=7</xsl:attribute>7</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.8.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;style=8</xsl:attribute>8</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.9.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;style=9</xsl:attribute>9</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=column&amp;style=10</xsl:attribute>10</a>
            </td-->

            <td>
             <xsl:if test="@HasKarate=1">
              <!--a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.r.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=1&amp;format=raw</xsl:attribute>R</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.x.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=1&amp;format=xsl</xsl:attribute>X</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.u.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=1&amp;format=xml</xsl:attribute>U</a-->
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.1.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=1</xsl:attribute>1</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.2.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=2</xsl:attribute>2</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.3.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=3</xsl:attribute>3</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.4.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=4</xsl:attribute>4</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.5.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=5</xsl:attribute>5</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.6.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=6</xsl:attribute>6</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.7.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=7</xsl:attribute>7</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.8.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=8</xsl:attribute>8</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.9.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=9</xsl:attribute>9</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=karate&amp;style=10</xsl:attribute>10</a>
             </xsl:if>
             <xsl:if test="@HasKarate!=1">N/A</xsl:if>
            </td>

            <td>
             <xsl:if test="@HasCheer=1">
              <!--a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.r.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=1&amp;format=raw</xsl:attribute>R</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.x.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=1&amp;format=xsl</xsl:attribute>X</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.u.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=1&amp;format=xml</xsl:attribute>U</a-->
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.1.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=1</xsl:attribute>1</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.2.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=2</xsl:attribute>2</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.3.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=3</xsl:attribute>3</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.4.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=4</xsl:attribute>4</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.5.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=5</xsl:attribute>5</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.6.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=6</xsl:attribute>6</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.7.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=7</xsl:attribute>7</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.8.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=8</xsl:attribute>8</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.9.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=9</xsl:attribute>9</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=cheer&amp;style=10</xsl:attribute>10</a>
             </xsl:if>
             <xsl:if test="@HasCheer!=1">N/A</xsl:if>
            </td>

            <td>
             <xsl:if test="@HasSoccer=1">
              <!--a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.r.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=1&amp;format=raw</xsl:attribute>R</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.x.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=1&amp;format=xsl</xsl:attribute>X</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.u.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=1&amp;format=xml</xsl:attribute>U</a-->
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.1.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=1</xsl:attribute>1</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.2.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=2</xsl:attribute>2</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.3.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=3</xsl:attribute>3</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.4.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=4</xsl:attribute>4</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.5.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=5</xsl:attribute>5</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.6.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=6</xsl:attribute>6</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.7.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=7</xsl:attribute>7</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.8.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=8</xsl:attribute>8</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.9.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=9</xsl:attribute>9</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=soccer&amp;style=10</xsl:attribute>10</a>
             </xsl:if>
             <xsl:if test="@HasSoccer!=1">N/A</xsl:if>
            </td>

            <td>
             <xsl:if test="@HasHipHop=1">
              <!--a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.r.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=1&amp;format=raw</xsl:attribute>R</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.x.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=1&amp;format=xsl</xsl:attribute>X</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.u.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=1&amp;format=xml</xsl:attribute>U</a-->
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.1.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=1</xsl:attribute>1</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.2.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=2</xsl:attribute>2</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.3.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=3</xsl:attribute>3</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.4.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=4</xsl:attribute>4</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.5.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=5</xsl:attribute>5</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.6.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=6</xsl:attribute>6</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.7.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=7</xsl:attribute>7</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.8.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=8</xsl:attribute>8</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.9.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=9</xsl:attribute>9</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=hiphop&amp;style=10</xsl:attribute>10</a>
             </xsl:if>
             <xsl:if test="@HasHipHop!=1">N/A</xsl:if>
            </td>

            <td>
             <xsl:if test="@HasSafe=1">
              <!--a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.r.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=1&amp;format=raw</xsl:attribute>R</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.x.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=1&amp;format=xsl</xsl:attribute>X</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.u.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=1&amp;format=xml</xsl:attribute>U</a-->
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.1.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=1</xsl:attribute>1</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.2.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=2</xsl:attribute>2</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.3.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=3</xsl:attribute>3</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.4.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=4</xsl:attribute>4</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.5.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=5</xsl:attribute>5</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.6.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=6</xsl:attribute>6</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.7.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=7</xsl:attribute>7</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.8.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=8</xsl:attribute>8</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.9.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=9</xsl:attribute>9</a>
              <a><xsl:attribute name="href"><xsl:value-of select="@fyName"/>.10.wordml.xml?cmd=report&amp;flyerid=<xsl:value-of select="@fyID"/>&amp;report=options&amp;sport=safe&amp;style=10</xsl:attribute>10</a>
             </xsl:if>
             <xsl:if test="@HasSafe!=1">N/A</xsl:if>
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



