// @file     DatabaseParser.groovy
// @author   Mac Radigan
// @version  $Id: DatabaseParser.groovy 91 2012-06-10 06:55:21Z mac.radigan $

package org.radigan.ycoa.service

import org.radigan.ycoa.process.service.Recordset
import org.radigan.ycoa.process.service.Record
import groovy.util.slurpersupport.GPathResult

public class DatabaseParser {

  public DatabaseParser() {
  }

  public static Recordset parse(File file) {
    def xml = new XmlSlurper().parseText(file.text)
    return parse(xml)
  }

  public static Recordset parse(GPathResult xml) {
    Recordset recordset = new Recordset()
    xml.children().each { row -> 
      def fields = [:]
      row.attributes().each { key, value -> 
        fields[key] = null
        if(!fields[key]) try {
          fields[key] = Integer.parseInt(value)
        } catch(e) {
        }
        if(!fields[key]) try {
          fields[key] = Boolean.parseBoolean(value)
        } catch(e) {
        }
        if(!fields[key]) try {
          fields[key] = value
        } catch(e) {
        }
      }
      recordset << new Record(fields)
    }
    return recordset
  }

}

// *EOF*
