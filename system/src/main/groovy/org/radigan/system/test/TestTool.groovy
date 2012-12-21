// @file     TestTool
// @author   Mac Radigan
// @version: $Id: TestTool.groovy 67 2012-04-03 04:12:20Z mac.radigan $

package org.radigan.system.test

//import org.apache.commons.mail.*
import org.radigan.system.tools.Tool
import org.radigan.ycoa.scan.service.*

public class TestTool extends Tool {

  public String getName() {
    return "test"
  }

  public String getDescription() {
    return "test"
  }

  public void initialize() {
    cli.usage = "${getName()} -f <filename> [-h]"
    cli.with {
        h longOpt: 'help',   'show usage information'
        g longOpt: 'debug',  'turn debugging on'
        f longOpt: 'file',   'file',  args:1, argName:'file', required:true
    }
  }

  public int run() {
    //testEmail()
    return 0
  }


/*
  public void testEmail() {
    // Create the attachment
    EmailAttachment attachment = new EmailAttachment()
    attachment.setURL(new URL("http://www.apache.org/images/asf_logo_wide.gif"))
    attachment.setDisposition(EmailAttachment.ATTACHMENT)
    attachment.setDescription("Apache logo")
    attachment.setName("Apache logo")
    // Create the email message
    MultiPartEmail email = new MultiPartEmail()
    email.setHostName("mail.myserver.com")
    email.addTo("joe@somewhere.org", "John Doe")
    email.setFrom("me@apache.org", "Me")
    email.setSubject("The logo")
    email.setMsg("Here is Apache's logo")
    // add the attachment
    email.attach(attachment)
    // send the email
    email.send();
  }
*/

}

/* *EOF* */
