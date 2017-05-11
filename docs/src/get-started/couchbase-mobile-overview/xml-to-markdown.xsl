<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:functx="http://www.functx.com"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        version="2.0">
  
  <xsl:output method="text"/>
  <xsl:strip-space elements="*"/>
  
  <xsl:param name="outputdir" select="outputdir"/>
  <xsl:param name="TokenizedPath" select="tokenize(base-uri(), '/')"/>
  <xsl:param name="OutputFilename" select="$TokenizedPath[last() - 1]"/>
  <xsl:param name="Permalink" select="concat($TokenizedPath[last() - 2], '/', $TokenizedPath[last() - 1], '/index.html')"/>
  
  <xsl:template match="/guide/introduction">
    <xsl:message><xsl:value-of select="$outputdir"/></xsl:message>
    <xsl:result-document href="{concat($outputdir, replace($Permalink, '.html', '.md'))}" method="text">---
title: title
permalink: <xsl:value-of select="$Permalink"/>
---
      
    <xsl:apply-templates/>
    </xsl:result-document>
  </xsl:template>
  
  <xsl:template match="paragraph">
    <xsl:value-of select="normalize-space(string())"/>
    <xsl:text>&#xa;&#xa;</xsl:text> <!-- Block element -->
  </xsl:template>
  
  <xsl:template match="topic/title">
    <xsl:value-of select="concat('## ', text())" />
    <xsl:text>&#xa;&#xa;</xsl:text> <!-- Block element -->
  </xsl:template>
  
  <xsl:template match="topic/body/section/title">
    <xsl:value-of select="concat('### ', text())" />
    <xsl:text>&#xa;&#xa;</xsl:text> <!-- Block element -->
  </xsl:template>
  
  <xsl:template match="text()"/>
  
</xsl:stylesheet>