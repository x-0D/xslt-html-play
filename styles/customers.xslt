<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/>

<xsl:param name="load_stylesheet" select="'true'"/>

<!-- Template for the customers root element -->
<xsl:template match="/">
  <div class="section-header">
    <h2>Customer Management</h2>
    <p>View and manage your customer relationships</p>
    <xsl:if test="$load_stylesheet = 'true'">
      <link rel="stylesheet" href="../styles/style.css"/>
    </xsl:if>
  </div>
  
  <div class="data-container">
    <xsl:apply-templates select="customers/customer"/>
  </div>
</xsl:template>

<!-- Template for each customer -->
<xsl:template match="customer">
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
      <span>Email:</span> <xsl:value-of select="email"/>
    </div>
    
    <div class="card-detail">
      <span>Phone:</span> <xsl:value-of select="phone"/>
    </div>
    
    <div class="card-detail">
      <span>Address:</span> <xsl:value-of select="address"/>
    </div>
    
    <div class="card-detail">
      <span>Segment:</span> <xsl:value-of select="segment"/>
    </div>
    
    <div class="card-detail">
      <span>Last Purchase:</span> <xsl:value-of select="last_purchase"/>
    </div>
  </div>
</xsl:template>

</xsl:stylesheet>