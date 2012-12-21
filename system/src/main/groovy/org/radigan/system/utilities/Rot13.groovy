// @file     Rot13.groovy
// @author   Mac Radigan
// @version: $Id: Rot13.groovy 64 2012-04-02 01:15:38Z mac.radigan $

package org.radigan.system.utilities

public class Rot13 {

  public static String encode(String message) {
    return rot13(message)
  }

  public static String decode(String message) {
    return rot13(message)
  }

  public static String rot13(String message) {
    def sb = new StringBuffer()
    for (int index = 0; index < message.length(); index++) {
      char c = message.charAt(index)
      if       (c >= 'a' && c <= 'm') c += 13;
      else if  (c >= 'n' && c <= 'z') c -= 13;
      else if  (c >= 'A' && c <= 'M') c += 13;
      else if  (c >= 'A' && c <= 'Z') c -= 13;
      sb.append(c)
    }
    return sb.toString()
  }

}

// *EOF*
