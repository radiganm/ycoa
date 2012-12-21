<?xml version="1.0" encoding="UTF-8"?>
<!--?xml version="1.0" encoding="ISO-8859-1"?-->
<!-- report_to_xsl2.xsl -->
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

        <xsl:apply-templates/>

      </out:template>
    </out:stylesheet>
  </xsl:template>

  <!-- insert binary data -->
  <!--xsl:template match="w:binData">
    <xsl:copy>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template-->

  <!-- Generate XPath expressions for the select attributes of 
       xsl:value-of instructions that we create -->
  <xsl:template name="xpath-expression">
    <xsl:variable name="ancestor-elements"
       select="ancestor-or-self::*[not(self::w:* or self::sl:* or self::aml:* or
                                       self::wx:* or self::w10:* or self::v:* or
                                       self::o:* or self::dt:* or self::st:*)]"/>
    <xsl:for-each select="$ancestor-elements">
      <xsl:text>/</xsl:text>
      <xsl:value-of select="name()"/>
    </xsl:for-each>
  </xsl:template>

  <!-- parent name -->
  <xsl:template name="parent-name">
    <xsl:variable name="ancestor-elements"
       select="parent::*[not(self::w:* or self::sl:* or self::aml:* or
                                       self::wx:* or self::w10:* or self::v:* or
                                       self::o:* or self::dt:* or self::st:*)]"/>
    <xsl:for-each select="$ancestor-elements">
      <xsl:value-of select="name()"/>
    </xsl:for-each>
  </xsl:template>

  <!-- logical if -->
  <xsl:template match="node()[@logic='if']">
    <out:if>
      <xsl:attribute name="test">
        <xsl:value-of select="@test"/>
      </xsl:attribute>
      <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </out:if>
  </xsl:template>

  <!-- table iterator -->
  <xsl:template match="dataset | node()[@type='table']">
    <out:for-each>
      <xsl:attribute name="select">
        <xsl:value-of select="name()"/>
        <!--xsl:call-template name="xpath-expression"/-->
      </xsl:attribute>
      <xsl:copy>
        <xsl:apply-templates/>
      </xsl:copy>
    </out:for-each>
  </xsl:template>

  <xsl:template match="node()[@type='field']">
    <!-- custom block level template -->

   <!--xsl:when test="child::*[1][self::w:p]"-->
   <!--xsl:if test="count(child::*) &gt; 0"-->

   <xsl:if test="child::*[1][self::w:p]">
      <xsl:comment><![CDATA[
        BLOCK-LEVEL TAG
        ]]></xsl:comment>
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:for-each select="w:p">
       <w:p>
         <xsl:apply-templates select="w:pPr"/>
         <xsl:apply-templates select="w:rPr"/>
         <w:r>
          <xsl:apply-templates select="w:pPr/w:rPr"/>
          <w:t>
            <out:value-of>
              <xsl:attribute name="select">
                <xsl:call-template name="parent-name"/>
              </xsl:attribute>
            </out:value-of>
          </w:t>
         </w:r>
       </w:p>
      </xsl:for-each>
    </xsl:copy>
   </xsl:if>

    <!-- custom run level template -->
    <!--xsl:if test="count(child::*) = 0"-->
   <xsl:if test="child::*[1][self::w:r]">
      <xsl:comment><![CDATA[
        RUN-LEVEL TAG
        ]]></xsl:comment>
      <xsl:copy>
        <w:r>
          <xsl:apply-templates select="../w:r/w:rPr"/>
          <w:t><out:value-of><xsl:attribute name="select"><xsl:value-of select="name()"/></xsl:attribute></out:value-of></w:t>
        </w:r>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

  <!-- custom run level template -->
  <!--xsl:template match="//LocationID">
    <out:text>_TESTING_</out:text>
    <xsl:for-each select="w:r">
     <w:r>
      <xsl:apply-templates select="w:rPr"/>
      <w:t>
        TEXT___<out:value-of select="/dataset/location/LocationID[@id='field']"/>___TEXT
        <out:text>_TESTING_</out:text>
      </w:t>
     </w:r>
    </xsl:for-each>
  </xsl:template-->

  <!-- By default, copy all elements, attributes, and text straight through
       so they will funciton as literal result elements, etc. -->
  <xsl:template match="@* | * | text()">
    <xsl:copy>
      <xsl:apply-templates select="@*|*|node()"/>
    </xsl:copy>
  </xsl:template>


  <!-- Selectively copy attribute and top-level children of w:wordDocument -->
  <xsl:template match="wordDocument">
    <xsl:copy>

    <!-- Create xml:space attribute only in the final result of the onload transformation -->
    <out:attribute name="xml:space">preserver</out:attribute>
  
      <!-- Copy the rest of w:wordDocument's attributes -->
      <xsl:apply-templates select="@*[not(name()='xml:space')]"/>

      <!-- Copy any top-level elements that come before o:DocumentProperties -->
      <xsl:apply-templates select="o:DocumentProperties/preceding-sibling::*"/>

      <!-- Preserve only the o:Title property; leave out all private info -->
      <o:DocumentProperties>
        <xsl:copy-of select="o:DocumentProperties/o:Title"/>
      </o:DocumentProperties>

      <!-- Preserver processing instructions inside o:CustomDocumentProperties
           (in the same way that XML2WORD.XSL does -->
      <o:CustomDocumentProperties>
        <out:if test="processing-instruction()">
          <o:processingInstructions dt:dt="string">
            <out:for-each select="processing-instruction()">
              <out:text>&lt;?</out:text>
              <out:value-of select="name()"/>
              <out:text>&#160;</out:text>
              <out:value-of select="."/>
              <out:text>?&gt;</out:text>
            </out:for-each>
          </o:processingInstructions>
          <!-- Copy any other custom document properties -->
          <xsl:apply-templates select="o:CustomDocumentProperties/*"/>
        </out:if>
      </o:CustomDocumentProperties>

      <!-- Process the rest of the top-level children of w:wordDocument -->
      <!-- MAC:  NOT SAXON COMPATABLE -->
      <!--xsl:apply-templates select="o:DocumentProperties/follow-sibling::*[not(self::o:CustomDocumentProperties)]"/-->

    </xsl:copy>
  </xsl:template>

  <!-- Set some XML-specific document options -->
  <xsl:template match="w:docPr">
    <xsl:copy>

      <!-- Process all other document options -->
      <!-- MAC:  NOT SAXON COMPATABLE -->
      <!--xsl:apply-templates select="*[not(self::w:removeWordSchemaOnSave or
                                         self:w:showXMLTags)]"/-->

      <!-- Turn "Save data only" back on (as it was likely off in the
           first place so that this stylesheet could be applied -->
      <w:removeWordSchemaOnSave/>

      <!-- Force "Show XML tags" to "off", as opposed to application state -->
      <w:showXMLTags w:val="off"/>

      <!-- Insert some commented-out XML document options that you may want
           to manually turn on -->
      <xsl:comment><![CDATA[
        These are some XML save options you may want to set:
          <w:ignoreMixedContent/>
          <w:useXSLTWhenSaving/>
          <w:saveThroughXSLT xslt=""/>
          <w:saveInvalidXML/>
        ]]></xsl:comment>

    </xsl:copy>
  </xsl:template>

  <!-- Remove these settings, because they were probably only set 
       to enable this transformation in the first place -->
  <xsl:template match="w:useXSLTWhenSaving | w:saveThroughXSLT | w:saveInvalidXML"/>

  <!-- Insert xsl:value-of instructions into custom run-level leaf tags
       (identified by the presence of custom placeholder text) -->
  <!--xsl:template match="*[@w:placeholder][ancestor::w:p]">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:copy-of select="w:permStart"/>
      <w:r>
        <xsl:copy-of select="(w:r/w:rPr)[1]"/>
        <w:t>
          <out:value-of>
            <xsl:attribute name="select">
              <xsl:call-template name="xpath-expression"/>
            </xsl:attribute>
          </out:value-of>
        </w:t>
      </w:r>
      <xsl:copy-of select="w:permEnd"/>
    </xsl:copy>
  </xsl:template-->

  <!-- Wrap whitespace-only text in w:t elements with xsl:text to ensure
       that it doesn't get stripped when Word loads the onload stylesheet -->
  <xsl:template match="w:t[not(normalize-space(.))]">
    <xsl:copy>
      <out:text>
        <xsl:value-of select="."/>
      </out:text>
    </xsl:copy>
  </xsl:template>
  
  <!-- Generate XPath expressions for the select attributes of 
       xsl:value-of instructions that we create MOVED UPWARD -->


</xsl:stylesheet>




