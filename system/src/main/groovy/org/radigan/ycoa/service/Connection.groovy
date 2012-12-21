// @file     Service
// @author   Mac Radigan
// @version  $Id: Connection.groovy 91 2012-06-10 06:55:21Z mac.radigan $

package org.radigan.ycoa.service

import org.apache.commons.httpclient.*
import org.apache.commons.httpclient.cookie.CookiePolicy
import org.apache.commons.httpclient.cookie.CookieSpec
import org.apache.commons.httpclient.methods.*
import org.apache.log4j.Logger

public class Connection {
  protected static log = Logger.getLogger(Connection.class.getName())
  protected String server = null
  protected int port = 80
  protected String user = null
  protected String password = null
  protected HttpClient client = new HttpClient()

  public Connection(String server, int port) {
    this.server = server
    this.port = port
    client.getHostConfiguration().setHost(server, port, "http")
    client.getParams().setCookiePolicy(CookiePolicy.BROWSER_COMPATIBILITY)
  }

  public Connection(Connection connection) {
    this.server = connection.getServer()
    this.port = connection.getPort()
    //this.user = connection.getUser()
    //this.password = connection.getPassword()
    client.getHostConfiguration().setHost(server, port, "http")
    client.getParams().setCookiePolicy(CookiePolicy.BROWSER_COMPATIBILITY)
  }

  public int getPort() {
    return port
  }

  public String getUser() {
    return user
  }

  public String getPassword() {
    return password
  }

  public String getServer() {
    return server
  }

  public String toString() {
    def sb = new StringBuffer()
    sb << "[${user}:${password}@${server}:${port}]"
    return sb.toString()
  }

  // login method
  public boolean login(String user=null, String password=null) throws Exception {
    newClient()
    if(user) this.user = user
    if(password) this.password = password
    // 
    // AUTHORIZATION
    // 
    //log.debug "LOGIN> ${this.user} : ${this.password}"
    CookieSpec cookiespec = CookiePolicy.getDefaultSpec()
    Cookie[] cookies
    cookies = cookiespec.match(server, port, "/", false, client.getState().getCookies())
    cookies.each { log.debug 'cookie: '+it }
    PostMethod authpost = new PostMethod("/index.asp?v1=login.asp&URLFromKS=")
    def nvps = new NameValuePair[2]
    nvps[0] = new NameValuePair("login_username", this.user)
    nvps[1] = new NameValuePair("login_password", this.password)
    authpost.setRequestBody(nvps)
    client.executeMethod(authpost)
    //log.debug 'logon response:  ' + authpost.getStatusLine().toString()
    cookies = cookiespec.match(server, port, "/", false, client.getState().getCookies())
    //cookies.each { log.debug 'cookie: '+it }
    int statuscode = authpost.getStatusCode()
    if( authpost.getResponseHeader("location") != null ) {
      def redirect = authpost.getResponseHeader("location").getValue()
    }
    log.debug 'http status:  ' + statuscode
    def returnStatus = false
    if(HttpStatus.SC_OK == statuscode) {
      returnStatus = false
    } else if(HttpStatus.SC_MOVED_TEMPORARILY == statuscode) {
      returnStatus = true
    } else if(HttpStatus.SC_MOVED_PERMANENTLY == statuscode) {
      returnStatus = true
    } else {
      returnStatus = false
    }
    //log.debug 'return status:  ' + returnStatus
    if(!returnStatus) {
      def response = authpost.getResponseBodyAsString()
      log.debug "AUTHENTICATION FAILURE:\n${response}"
    }
    authpost.releaseConnection()
    return returnStatus
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

  public void newClient() {
    client = new HttpClient()
    client.getHostConfiguration().setHost(server, port, "http")
    client.getParams().setCookiePolicy(CookiePolicy.BROWSER_COMPATIBILITY)
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
          throw new Exception(errorMessage)
        } else {
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
