// @file     ServiceClient
// @author   Mac Radigan
// @version  $Id: ServiceClient.groovy 64 2012-04-02 01:15:38Z mac.radigan $

package org.radigan.ycoa.service

import org.apache.commons.httpclient.*
import org.apache.commons.httpclient.cookie.CookiePolicy
import org.apache.commons.httpclient.cookie.CookieSpec
import org.apache.commons.httpclient.methods.*

public class ServiceClient {

  private server = null;
  private port = 80;
  private user = null;
  private password = null;
  private HttpClient client = new HttpClient();

  public ServiceClient(server, port, user, password) {
    this.server = server
    this.port = port
    this.user = user
    this.password = password
    client.getHostConfiguration().setHost(server, port, "http");
    client.getParams().setCookiePolicy(CookiePolicy.BROWSER_COMPATIBILITY);
  }

  // login method
  public boolean login() throws Exception {
    // 
    // AUTHORIZATION
    // 
    CookieSpec cookiespec = CookiePolicy.getDefaultSpec()
    Cookie[] cookies
    cookies = cookiespec.match(server, port, "/", false, client.getState().getCookies())
    //cookies.each { println 'cookie: '+it }
    PostMethod authpost = new PostMethod("/index.asp?v1=login.asp&URLFromKS=")
    def nvps = new NameValuePair[2]
    nvps[0] = new NameValuePair("login_username", user)
    nvps[1] = new NameValuePair("login_password", password)
    authpost.setRequestBody(nvps)
    client.executeMethod(authpost)
    authpost.releaseConnection()
    //println 'logon response:  ' + authpost.getStatusLine().toString()
    cookies = cookiespec.match(server, port, "/", false, client.getState().getCookies())
    //cookies.each { println 'cookie: '+it }
    int statuscode = authpost.getStatusCode()
    if( authpost.getResponseHeader("location") != null ) {
      def redirect = authpost.getResponseHeader("location").getValue()
    }
    if(HttpStatus.SC_OK == statuscode) {
      return false
    } else if(HttpStatus.SC_MOVED_TEMPORARILY == statuscode) {
      return true
    } else if(HttpStatus.SC_MOVED_PERMANENTLY == statuscode) {
      return true
    } else {
      return false
    }
  }

  // download method
  public String download(url) throws Exception {
    // AUTHORIZATION
    if( login() ) {
      // DOWNLOAD
      GetMethod get = new GetMethod(url)
      client.executeMethod(get)
      def bufferedReader = new BufferedReader( new InputStreamReader( get.getResponseBodyAsStream() ) )
      def line = ""
      def sb = new StringBuffer()
      while( (line = bufferedReader.readLine()) != null ) {
        sb.append(line)
      }
      def response = sb.toString()
      //def response = get.getResponseBodyAsString()
      get.releaseConnection()
      return response
    } else {
      return "<root>authentication failed</root>\n"
    }
  } 

  // webservice method
  public String webservice(url) throws Exception {
    // AUTHORIZATION
    if( login() ) {
      // WEBSERVICE
      GetMethod get = new GetMethod(url)
      client.executeMethod(get)
      def bufferedReader = new BufferedReader( new InputStreamReader( get.getResponseBodyAsStream() ) )
      def line = ""
      def sb = new StringBuffer()
      while( (line = bufferedReader.readLine()) != null ) {
        sb.append(line)
      }
      def response = sb.toString()
      //def response = get.getResponseBodyAsString()
      //println "RESPONSE -> " + response
      def result = response
      try {
        def xml = new XmlParser().parseText(response)
        def soap = new groovy.xml.Namespace("http://www.w3.org/2001/12/soap-envelope", 'soap')
        def writer = new StringWriter()
        new XmlNodePrinter(new PrintWriter(writer)).print(xml)
        result = writer.toString()
        def matcher = ( result =~ /(?ms)(<root>.*<\/root>)/ )
        def nullMatcher = ( result =~ /(?ms)(<root\/>)/ )
        def errorMatcher = ( result =~ /(?ms)<faultstring[^>]*>(.*)<\/faultstring>/ )
        if( matcher.count > 0 ) {
          def root = matcher[0][0]
          return root+"\n"
        } else if( nullMatcher.count > 0 ) {
          return "<root/>\n"
        } else if( errorMatcher.count > 0 ) {
          def errorMessage = errorMatcher[0][1]
          println "ERROR: ${errorMessage}"
          throw new Exception(errorMessage)
        } else {
          println "ERROR: ${result}"
          throw new Exception("Root node not found.")
        }
      } catch(e) {
        def errMatcher = ( result =~ /(?ms)<FONT FACE='courier'>(.*)<\/FONT>/ )
        if( errMatcher.count > 0 ) {
          def errMessage = errMatcher[0][1].replaceAll("<[^>]*>","")
          throw new Exception(errMessage)
        } else {
          throw new Exception(e)
        }
      }
    } else {
      throw new Exception("Authentication failed.")
    }
  }

}

/* *EOF* */
