<?xml version="1.0" encoding="UTF-8"?>
<!--?xml version="1.0" encoding="ISO-8859-1"?-->
<!-- wordml-styles-template-2-xsl.xsl -->
<!--
-->

<xsl:stylesheet version="2.0"   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                                xmlns:out="dummy"
				xmlns:w="http://schemas.microsoft.com/office/word/2003/wordml"
				xmlns:v="urn:schemas-microsoft-com:office:vml"
				xmlns:w10="urn:schemas-microsoft-com:office:word" 
				xmlns:sl="http://schemas.microsoft.com/schemaLibrary/2003/core" 
				xmlns:aml="http://schemas.microsoft.com/aml/2001/core" 
				xmlns:wx="http://schemas.microsoft.com/office/word/2003/auxHint" 
				xmlns:o="urn:schemas-microsoft-com:office:office" 
				xmlns:dt="uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" 
	 		        xmlns:st="urn:schemas-microsoft-com:office:smarttags"
				xmlns:ns0="http://radigan.org/ycoa/private/1.0"
			        exclude-result-prefixes="v st">

  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>


  <!-- Use the "out" prefix for XSLT instructions in the result stylesheet -->
  <xsl:namespace-alias stylesheet-prefix="out" result-prefix="xsl"/>

  <!-- Create stylesheet root element and root template file -->
  <xsl:template match="/">
    <out:stylesheet version="2.0">

      <out:template match="/">
        <out:processing-instruction name="mso-application">
          <out:text>progid="Word.Document"</out:text>
        </out:processing-instruction>
	<!--out:apply-templates select="@*|*|node()"/-->
	<out:apply-templates select="@*|*|node()"/>
      </out:template>

      <out:template match="w:styles">
	<xsl:copy-of select="//w:styles"/>
      </out:template>

      <out:template match="@*|*|node()">
        <out:copy>
          <out:apply-templates select="@*|*|node()"/>
        </out:copy>
      </out:template>

    </out:stylesheet>
  </xsl:template>

  <!-- Create a template that applies the styles in the source document -->
  <xsl:template match="w:styles">
	 <!--+ 
	     |  copy the styles from the source document and add them
	     |  to the output of the stylesheet
	     |
	     +-->

	<!--w:versionOfBuiltInStylenames w:val="4"/>
	<w:latentStyles w:defLockedState="off" w:latentStyleCount="156"/>
	<w:style w:type="paragraph" w:styleId="pYCOAFlyerHeaderSport1">
	 <w:name w:val="pYCOAFlyerHeaderSport1"/><w:basedOn w:val="Heading2"/><w:rsid w:val="00490184"/><w:pPr><w:pStyle w:val="pYCOAFlyerHeaderSport1"/></w:pPr><w:rPr><w:rFonts w:ascii="Ravie" w:h-ansi="Ravie"/><wx:font wx:val="Ravie"/><w:color w:val="FF0000"/><w:sz w:val="40"/></w:rPr>
	</w:style-->

	<!--xsl:copy-of/-->
        <!--xsl:copy>
          <xsl:apply-templates select="@*|node()"/>
        </xsl:copy-->

  </xsl:template>

  <!-- Create the identity tranform in the resulting stylesheet -->
  <!--xsl:template match="@*|node()">
      <out:template match="@*|node()">
        <out:copy>
          <out:apply-templates select="@*|node()"/>
        </out:copy>
      </out:template>
  </xsl:template-->

</xsl:stylesheet>



