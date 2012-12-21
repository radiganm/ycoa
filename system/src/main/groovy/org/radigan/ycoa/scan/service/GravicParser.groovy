// @file     GravicParser.groovy
// @author   Mac Radigan
// @version  $Id: GravicParser.groovy 64 2012-04-02 01:15:38Z mac.radigan $

package org.radigan.ycoa.scan.service

import org.radigan.ycoa.process.service.Recordset
import org.radigan.ycoa.process.service.Record

public class GravicParser {

  public GravicParser() {
  }

  public static Recordset parse(File file) {
    Recordset recordset = new Recordset()
    def types = [:]
    def xml = new XmlSlurper().parseText(file.text).declareNamespace(
      s:'uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882', 
      dt:'uuid:C2F41010-65B3-11d1-A29F-00AA00C14882',
      rs:'urn:schemas-microsoft-com:rowset',
      z:'#RowsetSchema'
      )
    xml.'s:Schema'.'s:ElementType'.AttributeType.each { attributeType ->
      types["${attributeType.@name}"] = "${attributeType.'s:datatype'.@'s:type'}"
    }
    //xml.'rs:data'.'z:row'.each { row ->
    //def row = xml.'rs:data'.'z:row'[0] // bug in Gravic, only use first row
    // bug in Gravic, only use last row
    def row = null
    xml.'rs:data'.'z:row'.each { r -> row = r }
      def fields = [:]
      row.attributes().each { key, value -> 
        switch(types[key]) {
          case "int":
            fields[key] = Integer.parseInt(value)
            break
          case "string":
            fields[key] = value
            break
          case "boolean":
            fields[key] = Boolean.parseBoolean(value)
            break
          default:
            throw new Exception("Cannot resolve data type ${types[key]} for ${key}.")
        }
        fields[key] = value 
      }
      def sortedFields = [:]
      types.each { key, value -> sortedFields[key] = fields[key] }
      recordset << new Record(sortedFields)
    //}
    return recordset
  }

}

// *EOF*
