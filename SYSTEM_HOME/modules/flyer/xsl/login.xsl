<?xml version="1.0"?>
<!--
-->

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<!-- Get the name from the request paramter -->
<xsl:param name="remoteip"/>
<xsl:param name="market"/>

<xsl:template match="authentication">
  <html>
    <xsl:choose>
      <xsl:when test="//machine/@ipaddress=$remoteip">
        <!-- AUTHORIZED -->

        <head>
  	  <title>Young Champions of America Intranet</title>
          <link rel="stylesheet" type="text/css" href="res/IEstyle.css"/>
        </head>
        <body class="BodyBG" height="100%">
        <xsl:if test="$market!=''">
          <xsl:attribute name="onload">
	    SetFocus();
          </xsl:attribute>
        </xsl:if>
        

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
                 <table width="100%" height="20" border="0" cellspacing="0" cellpadding="0" bgcolor="#CC6700" class="header">
                   <tr valign="top">
		     <td>
		       <table width="100%" border="0" cellspacing="0" cellpadding="0" height="56">
		         <tr bgcolor="#8D0102">
		           <td><img src="res/default/YOLogo.jpg" alt="Young Champions of America" hspace="0" vspace="0" border="0"/>
                           <br/> 
                           </td>
			  </tr>
		       </table>
		     </td>
	           </tr>
	           <tr>
		    <td>
		      <table width="100%" border="0" cellspacing="0" cellpadding="0" height="20" class="headerLinkRow">
		        <tr>
			  <td width="25%">
                              <a href="#" class="headerlink">FAQs</a>  |
			      <a href="http://www.ycoaoffice.com/index.aspx" class="headerlink">About Us</a>  |	
			      <a href="http://www.ycoaoffice.com/index.aspx?cmd=viewcontact" class="headerlink">Contact Us</a>
			  </td>
		          <td align="right" width="45%">
			      <a href="login" class="headerlink">Log In</a>
			  </td>
			</tr>
		      </table>		
		     </td>
	            </tr>
                 </table>
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
<xsl:if test="$market!=''">
      <form action="do-login" method="post" name="login" id="login">

        <input type="hidden" name="login_market" id="login_market">
          <xsl:attribute name="value">
            <xsl:value-of select="$market"/>
          </xsl:attribute>
        </input>
        <table cellpadding="0" cellspacing="0" border="0" class="loginBoxBorder">
	  <tr class="loginHeader">
	    <td>
	    <!-- Login Box Top Portion -->
	      <!-- Title Bar -->
	      <table cellpadding="0" cellspacing="0" border="0" width="362" height="20">
	        <tr>
	       	  <td class="loginTitle">Please Login</td>		
		</tr>
              </table>
	      <!-- End Title Bar -->
	      <!-- End Login Box Top Portion -->
	      <!-- Login Box Middle Portion -->
	      <table cellpadding="0" cellspacing="0" border="0" width="362">
	        <tr>
		  <td width="346" height="20"><img src="res/default/trans.gif" width="346" height="20" border="0"/></td>
		</tr>
		<tr>
		  <td align="center" valign="top">
		    <table border="0" cellspacing="0" cellpadding="0">
		      <tr><td colspan="3">
		        <br/><br/></td></tr>
                      <tr>
                        <td>username</td> 
                        <td>
                        </td>
                        <td>
                          <input type="text" class="textbox" name="login_username" maxlength="12" size="12"/>
                        </td>							
			</tr>
			<tr>
			  <td><img src="res/default/trans.gif" height="10" border="0"/></td>
			</tr>
			<tr>
			  <td>password</td>
                          <td></td>
                          <td><input type="password" class="textbox" name="login_password" maxlength="12" size="12"/></td>
			</tr>
		      </table>
		  </td>
		</tr>
		<tr>
		  <td width="346" height="20"><img src="res/default/trans.gif" width="346" height="20" border="0"/></td>
		</tr>			
              </table>
	      <!-- End Login Box Middle Portion -->
	      <!-- Login Box Bottom Portion -->
	      <table cellpadding="0" cellspacing="0" border="0" width="362" height="23">
		<tr>
		  <td width="163" height="23" valign="top"><input type="Image" onclick="" src="res/default/login_unselected.gif" alt="login" width="163" height="23" border="0" onMouseOver="this.src='res/default/login_selected.gif';" onMouseOut="this.src='res/default/login_unselected.gif';"/></td>						
		</tr>
	      </table>
	      <!-- End Login Box Bottom Portion -->
	    </td>
	  </tr>
	</table>

      </form>
</xsl:if>
<!-- /*** 
      *
      *     if no market is selected, then display links to choose market
      *
      ***/ -->
<xsl:if test="$market=''">
        <table cellpadding="0" cellspacing="0" border="0" class="loginBoxBorder">
	  <tr class="loginHeader">
	    <td>
	    <!-- Login Box Top Portion -->
	      <!-- Title Bar -->
	      <table cellpadding="0" cellspacing="0" border="0" width="362" height="20">
	        <tr>
	       	  <td class="loginTitle">Select a Market</td>		
		</tr>
              </table>
	      <!-- End Title Bar -->
	      <!-- End Login Box Top Portion -->
	      <!-- Login Box Middle Portion -->
	      <table cellpadding="0" cellspacing="0" border="0" width="362">
	        <tr>
		  <td width="346" height="20"><img src="res/default/trans.gif" width="346" height="20" border="0"/></td>
		</tr>
		<tr>
		  <td align="center" valign="top">
		    <table border="0" cellspacing="0" cellpadding="0">
		      <tr> 
                        <td colspan="3">
		        </td>
                      </tr>
                      <tr><td><a href="login@az.html">Arizona</a></td></tr>
                      <tr><td><a href="login@co.html">Colorado</a></td></tr>
                      <tr><td><a href="login@ks.html">Kansas</a></td></tr>
                      <tr><td><a href="login@nc.html">North Carolina</a></td></tr>
		      </table>
		  </td>
		</tr>
		<tr>
		  <td width="346" height="20"><img src="res/default/trans.gif" width="346" height="20" border="0"/></td>
		</tr>			
              </table>
	      <!-- End Login Box Middle Portion -->
	      <!-- Login Box Bottom Portion -->
	      <table cellpadding="0" cellspacing="0" border="0" width="362" height="23">
		<tr>
		</tr>
	      </table>
	      <!-- End Login Box Bottom Portion -->
	    </td>
	  </tr>
	</table>
</xsl:if>
	
      <table align="center">		
	<tr>
   	  <td><img src="res/spacers/spacer.trans.gif" width="1" height="10" border="0" alt=""/></td>		
 	</tr>
        <tr>
	  <td>
	    <table WIDTH="500" border="0" cellspacing="0" cellpadding="5" CLASS="MSGFormatTable">
	      <tr>
	        <td valign="TOP" class="MSGFormatBody">
		  <b>** Attention ** UPDATED 07/06/05 by Mac</b><br/> The application is undergoing enhancements.<br/> <b>If you  have any issues please contact Kraig Hollingworth - ASAP </b><br/><br/>
If you have any questions please direct them to <a href="mailto:kraig@ycoaoffice.com">Kraig Hollingworth</a>.
<br/><br/>Thank You
	
                </td>
	      </tr>
	     </table>
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
             <xsl:when test="$market='az'">Arizona</xsl:when>
             <xsl:when test="$market='co'">Colorado</xsl:when>
             <xsl:when test="$market='ks'">Kansas</xsl:when>
             <xsl:when test="$market='nc'">North Carolina</xsl:when>
             <xsl:when test="$market='test'">TEST</xsl:when>
             <xsl:otherwise></xsl:otherwise>
           </xsl:choose>
           [<a href="login.html">DAX Extensions</a>] 
         </td>
	 <td align="right"> 2005 Young Champions of America. All rights reserved.  Powered by <a href="http://www.radigan.org" target="_blank" class="footerlink">Radigan.org.</a></td>
	 <td width="10"></td>
       </tr>
     </table>
    </td>
   </tr>
</table>
</div>

</body>


        <!-- END OF AUTHORIZED -->

      </xsl:when>
      <xsl:otherwise>
        <!-- NOT AUTHORIZED -->

        <head>
          <META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
          <META http-equiv="expires" content="0"/>
          <META http-equiv="pragma" content="nocache"/>
          <title>Nothing Here</title>
        </head>
        <body vlink="blue" link="blue" alink="red" bgcolor="white">
         <content>
          <h2 style="color: navy; text-align: center"><i>your IP address is <xsl:value-of select="$remoteip"/></i></h2>
          <p align="center">
            <i/>
          </p>
          <p align="center">
            <i/>
          </p>
         </content>
        </body>

      </xsl:otherwise>
    </xsl:choose>
  </html>
</xsl:template>

</xsl:stylesheet>
