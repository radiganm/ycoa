// @file     Md5.groovy
// @author   Mac Radigan
// @version: $Id: Md5.groovy 64 2012-04-02 01:15:38Z mac.radigan $

package org.radigan.system.utilities

import java.security.MessageDigest

public class Md5 {

  public static String encode(String message) {
    def digest = MessageDigest.getInstance("MD5")
    digest.update(message.bytes)
    def big = new BigInteger(1,digest.digest())
    return big.toString(16).padLeft(32,"0")
  }

}

// *EOF*


