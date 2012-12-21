<?xml version="1.0" encoding="UTF-8"?>
<!--
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                              xmlns:session="http://apache.org/cocoon/session/1.0"
                              xmlns:ycoa="http://radigan.org/ycoa/private/1.0"
                              xmlns="http://www.w3.org/1999/xhtml">


<xsl:template match="/">
  <!--html-->
        <!--head>
  	  <title>Young Champions of America Intranet</title>
          <link rel="stylesheet" type="text/css" href="res/IEstyle.css"/>
        </head-->
        <!--body class="BodyBG" height="100%"-->

<!-- /*** 
      *
      *     javascript here
      *
      ***/ -->
      <script language="JavaScript">
        function SetFocus() {
          document.login.login_username.focus();
	}
      </script>

<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">

             <!-- Header -->
<div name="header" id="header" style="position:absolute; top:0px">
             <tr valign="top">
               <td>
                 <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#CC6700" class="header">
                   <tr valign="top">
		     <td>
		       <table width="100%" border="0" cellspacing="0" cellpadding="0">
		         <tr bgcolor="#8D0102">
		           <td><img src="res/default/YOLogo.jpg" alt="Young Champions of America" hspace="0" vspace="0" border="0"/></td>
			  </tr>
		       </table>
		     </td>
	           </tr>
	           <tr valign="top">
		    <td>
		      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="20" class="headerLinkRow">
		        <tr valign="center">
			  <td width="25%">
                              <a href="/service/ycoa_private/main.html" class="headerlink">Main</a>  |
                              <a href="#" class="headerlink">FAQs</a>  |
			      <a href="http://www.ycoaoffice.com/index.aspx" class="headerlink">About Us</a>  |	
			      <a href="http://www.ycoaoffice.com/index.aspx?cmd=viewcontact" class="headerlink">Contact Us</a>
			      | <a href="/service/ycoa_private/wordml.xml" class="headerlink">TEST</a>
			  </td>
		          <td align="right" width="45%">
			      <a class="headerlink">
                                <xsl:attribute name="href">
                                  /service/ycoa_private/do-logout@<xsl:value-of select="/session/market"/>.html
                                </xsl:attribute>
                              </a>Log Out
			  </td>

			</tr>


		      </table>		

		     </td>
	            </tr>
                 </table>

                 <!-- /***
                       *
                       *  Title Bar
                       *
                       ***/-->
			<tr>
                         <td>
                          <table width="100%" align="center" class="BodyHeader" cellpading="0" cellspacing="0">
                            <tr>
                              <td width="100"></td>
                              <td align="center" class="BodyHeaderTitle" width="300">Extended Console</td>
                              <td width="100"></td>
                            </tr>
                          </table>
                          </td>
			</tr>



                </td>







              </tr>
</div>


  <!-- Main Content -->
<div name="main" id="main">
  <tr height="100%">
    <td valign="top" align="center">
      <table>
	<tr><td align="center"></td></tr>
      </table>

      <table align="center">		
	<tr>
   	  <td><img src="res/spacers/spacer.trans.gif" width="1" height="10" border="0" alt=""/></td>		
 	</tr>
        <tr>
	  <td>


	  </td>
	</tr>
	<tr>
	  <td><img src="res/spacers/spacer.trans.gif" width="1" height="10" border="0" alt=""/></td>		
	</tr>
      </table>
	
    </td>
  </tr>
</div>

</table>

<div name="footer" id="footer" style="position:absolute; bottom:0px">
<table border="0" width="100%" height="100%">
  <!-- Footer -->
  <tr valign="bottom" height="10">
    <td>

     <table width="100%" height="20" border="0" cellspacing="10" cellpadding="0" class="footer" bgcolor="#6487DC">
       <tr class="footerLinkRow2" valign="bottom">
	 <td nowrap="nowrap">
           <xsl:choose>
             <xsl:when test="/session/market='test'">TEST</xsl:when>
             <xsl:when test="/session/market='az'">Arizona</xsl:when>
             <xsl:when test="/session/market='co'">Colorado</xsl:when>
             <xsl:when test="/session/market='ks'">Kansas</xsl:when>
             <xsl:when test="/session/market='nc'">North Carolina</xsl:when>
             <xsl:otherwise>
               ERROR
             </xsl:otherwise>
           </xsl:choose>
           [<a href="#">DAX Extensions</a>]
         </td>
	 <td align="right"> 2005 Young Champions of America. All rights reserved.  Powered by <a href="http://www.radigan.org" target="_blank" class="footerlink">Radigan.org.</a></td>
	 <td width="10"></td>
       </tr>
     </table>
    </td>
   </tr>
</table>
</div>

<!--/body-->

  <!--/html-->
</xsl:template>

</xsl:stylesheet>
