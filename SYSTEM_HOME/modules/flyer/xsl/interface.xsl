<?xml version="1.0"?>
<!-- mp3directory_to_html.xsl -->
<!--
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:dir="http://apache.org/cocoon/directory/2.0"
                              xmlns:session="http://apache.org/cocoon/session/1.0"
                              xmlns:ycoa="http://radigan.org/ycoa/private/1.0"
                              xmlns="http://www.w3.org/1999/xhtml">
<xsl:param name="uri"/>

  <xsl:template match="/">
   <html>
    <head>
     <link href="res/IEstyle.css" type="text/css" rel="stylesheet"/>
    </head>
    <body>

     <div align="right" style="z-index:1">
       <a>
         <xsl:attribute name="href">
           /service/ycoa_private/do-logout@az.html
         </xsl:attribute>
         logout <session:getxml context="authentication" path="/authentication/ID"/>
       </a>
     </div>

     <xsl:apply-templates/>

    </body>
   </html>
  </xsl:template>

</xsl:stylesheet>



