<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/>

<xsl:param name="load_stylesheet" select="'true'"/>

<!-- Template for the leads root element -->
<xsl:template match="/">
  <div class="section-header">
    <h2>Lead Management</h2>
    <p>Track and manage potential customer opportunities</p>
    <xsl:if test="$load_stylesheet = 'true'">
      <link rel="stylesheet" href="../styles/style.css"/>
    </xsl:if>
  </div>
  
  <div class="data-container">
    <xsl:apply-templates select="leads/lead"/>
  </div>
</xsl:template>

<!-- Template for each lead -->
<xsl:template match="lead">
  <div class="card">
    <div class="card-title">
      <xsl:value-of select="name"/>
      <span class="status">
        <xsl:attribute name="class">
          <xsl:text>status status-</xsl:text>
          <xsl:value-of select="translate(status, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
        </xsl:attribute>
        <xsl:value-of select="status"/>
      </span>
    </div>
    
    <div class="card-detail">
      <span>Company:</span> <xsl:value-of select="company"/>
    </div>
    
    <div class="card-detail">
      <span>Email:</span> <xsl:value-of select="email"/>
    </div>
    
    <div class="card-detail">
      <span>Phone:</span> <xsl:value-of select="phone"/>
    </div>
    
    <div class="card-detail">
      <span>Source:</span> <xsl:value-of select="source"/>
    </div>
    
    <div class="card-detail">
      <span>Date Created:</span> <xsl:value-of select="date_created"/>
    </div>
    
    <div class="card-detail">
      <span>Notes:</span> <xsl:value-of select="notes"/>
    </div>
  </div>
</xsl:template>

</xsl:stylesheet>