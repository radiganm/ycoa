// @file     FlyerStation.groovy
// @author   Mac Radigan
// @version  $Id: FlyerStation.groovy 99 2012-06-13 00:48:19Z mac.radigan $

package org.radigan.ycoa.flyer.service

import java.util.List
import java.util.Map
import org.apache.log4j.Logger
import java.util.ServiceLoader
import java.lang.Iterable
import org.w3c.dom.Element
import org.w3c.dom.Document

import org.radigan.system.configuration.Configuration
import org.radigan.ycoa.process.service.Processor
import org.radigan.ycoa.service.ServiceFactory
import org.radigan.ycoa.service.DatabaseConnection
import org.radigan.ycoa.service.DatabaseParser
import org.radigan.ycoa.process.service.Recordset
import org.radigan.system.utilities.XmlUtilities

public class FlyerStation {
  protected static log = Logger.getLogger(FlyerStation.class.getName())
  protected File directory = new File("FLYER-OUT")
  protected File root = null
  protected DatabaseConnection databaseConnection = null
  protected boolean simulation = false
  protected String module = "FlyerCreation"

  public FlyerStation(DatabaseConnection databaseConnection, File root) {
    this.databaseConnection = databaseConnection
    this.root = root
  }

  public void setSimulation(boolean simulation) {
    this.simulation = simulation
  }

  public void setDirectory(File directory) {
    this.directory = directory
  }

  public String getOutline(int flyerId) {
    def sproc = "yy_RPFP_GetFlyerOutline"
    def parameters = ["FlyerID":flyerId]
    def result = databaseConnection.executeXml(module, sproc, parameters)
    //println DatabaseParser.parse(result).toString()
    return DatabaseConnection.format(result)
  }

  public String getPanel(int flyerId, String panel) {
    def sproc = "yy_RPFP_GetFlyerPanel"
    def parameters = ["FlyerID":flyerId, "Panel":panel]
    def result = databaseConnection.executeXml(module, sproc, parameters)
    //println DatabaseParser.parse(result).toString()
    return DatabaseConnection.format(result)
  }

  public Document processRawToOoxml(Document xmlRaw, Document xmlTemplate) {
    //
    // RAW to DATA
    //
    def xslDataFile = "${root}/modules/flyer/xsl/dataset-to-reportdata.xsl"
    def xslData = XmlUtilities.newDocument( new File(xslDataFile).text )
    def xmlData = XmlUtilities.xslt(xmlRaw, xslData)
    //println "=== DATA ==="
    //println XmlUtilities.parseToString(xmlData)
    //
    // RAW to DATA
    //
    def xslTemplateFile = "${root}/modules/flyer/xsl/report-to-wordxsl.xsl"
    def xslTemplate = XmlUtilities.newDocument( new File(xslTemplateFile).text )
    def xslReport = XmlUtilities.xslt(xmlTemplate, xslTemplate)
    //println "=== XSL ==="
    //println XmlUtilities.parseToString(xslReport)
    //
    // DATA to OOXML
    //
    def xmlFlyer = XmlUtilities.xslt(xmlData, xslReport)
    //println "=== FLYER ==="
    //println XmlUtilities.parseToString(xmlFlyer)
    return xmlFlyer
  }

  public void importSubreport(Document report, Element node, Document subreport) {
    def xpath = "//dataset"
    def xpathResult = XmlUtilities.findNodes(subreport, xpath)
    if( xpathResult.getSnapshotLength() > 0 ) {
      def subreportNode = (org.w3c.dom.Node)xpathResult.snapshotItem(0)
      def importedSubreportNode = (Element)report.importNode(subreportNode, true)
      def rootElement = report.getDocumentElement()
      rootElement.setAttribute( "xmlns:w", "http://schemas.microsoft.com/office/word/2003/wordml" )
      rootElement.setAttribute( "xmlns:v", "urn:schemas-microsoft-com:vml"  )
      rootElement.setAttribute( "xmlns:w10", "urn:schemas-microsoft-com:office:word"  )
      rootElement.setAttribute( "xmlns:sl", "http://schemas.microsoft.com/schemaLibrary/2003/core" )
      rootElement.setAttribute( "xmlns:aml", "http://schemas.microsoft.com/aml/2001/core" )
      rootElement.setAttribute( "xmlns:wx", "http://schemas.microsoft.com/office/word/2003/auxHint" )
      rootElement.setAttribute( "xmlns:o", "urn:schemas-microsoft-com:office:office" )
      rootElement.setAttribute( "xmlns:dt", "uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" )
      rootElement.setAttribute( "xmlns:st1", "urn:schemas-microsoft-com:office:smarttags" )
      node.replaceChild( importedSubreportNode, node.getFirstChild() )
    }
  }

  public String process(int flyerId, int reportSize) {
    // get flyer outline
    //println "FLYER:  getting flyer outline"
    def outline = getOutline(flyerId)
    //println "FLYER OUTLINE:  ${outline}"
    def xmlRaw = XmlUtilities.newDocument( outline )
    def templateFile = "${root}/modules/flyer/xml/FlyerOutline.wordml-template.xml" 
    def xmlTemplate = XmlUtilities.newDocument( new File(templateFile).text )
    def xmlFlyer = processRawToOoxml(xmlRaw, xmlTemplate)
    def panel = null
    // embed flyer panels
    def xpathResult = XmlUtilities.findNodes(xmlFlyer, '//logicXInclude')
    for (int nodeIndex = 0; nodeIndex < xpathResult.getSnapshotLength(); nodeIndex++) {
      def node = (org.w3c.dom.Node)xpathResult.snapshotItem(nodeIndex)
      def nodeMapAttributes = node.getAttributes()
      for(int attributeIndex=0; attributeIndex < nodeMapAttributes.getLength(); attributeIndex++) {
        def attribute = nodeMapAttributes.item(attributeIndex)
        if( attribute.getNodeName().equals("reportid") ) {
          if( attribute.getNodeValue().equals("FlyerPanelA") ) {
            panel = getPanel(flyerId, 'A')
          }
          if( attribute.getNodeValue().equals("FlyerPanelB") ) {
            panel = getPanel(flyerId, 'B')
          }
          if( attribute.getNodeValue().equals("FlyerPanelC") ) {
            panel = getPanel(flyerId, 'C')
          }
          if( attribute.getNodeValue().equals("FlyerPanelD") ) {
            panel = getPanel(flyerId, 'D')
          }
          xmlRaw = XmlUtilities.newDocument( panel )
          templateFile = "${root}/modules/flyer/xml/FlyerPanel.wordml-template.xml" 
          xmlTemplate = XmlUtilities.newDocument( new File(templateFile).text )
          def xmlSubFlyer = processRawToOoxml(xmlRaw, xmlTemplate)
          importSubreport(xmlFlyer, node, xmlSubFlyer)
        }
      }
    }
    // apply formatting
    //println "FLYER:  applying formatting"
    templateFile = "${root}/modules/flyer/xsl/format-to-wordxsl.xsl"
    xmlTemplate = XmlUtilities.newDocument( new File(templateFile).text )
    def formatFile = "${root}/modules/flyer/xml/FlyerFormat${reportSize}.wordml-format.xml"
    def xmlFormat = XmlUtilities.newDocument( new File(formatFile).text )
    def xslFormat = XmlUtilities.xslt(xmlFormat, xmlTemplate)
    def xmlFormattedFlyer = XmlUtilities.xslt(xmlFlyer, xslFormat)
    //
    // print result
    //
    //println "=== FLYER ==="
    //println "FLYER:  printing flyer"
    def data = XmlUtilities.parseToString(xmlFormattedFlyer)
    return data
  }

}

/* *EOF* */
