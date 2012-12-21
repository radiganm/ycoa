// @file     Encoder.groovy
// @author   Mac Radigan
// @version: $Id: Encoder.groovy 64 2012-04-02 01:15:38Z mac.radigan $

package org.radigan.system.utilities

public class Encoder {

  private String encoding = null

  public Encoder(String encoding) {
    this.encoding = encoding
  }

  public String encode(String message) {
    switch(encoding) {
      case "rot13":
        return Rot13.encode(message)
      case "md5":
        return Md5.encode(message)
    }
  }

  public String decode(String message) {
    switch(encoding) {
      case "rot13":
        return Rot13.decode(message)
    }
  }

}

// *EOF*
