<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/>

<xsl:param name="load_stylesheet" select="'true'"/>

<!-- Template for the inventory root element -->
<xsl:template match="/">
  <div class="section-header">
    <h2>Product Inventory</h2>
    <p>Manage your product catalog and inventory</p>
    <xsl:if test="$load_stylesheet = 'true'">
      <link rel="stylesheet" href="../styles/style.css"/>
    </xsl:if>
  </div>
  
  <div class="data-container">
    <xsl:apply-templates select="inventory/product"/>
  </div>
</xsl:template>

<!-- Template for each product -->
<xsl:template match="product">
  <div class="card">
    <div class="card-title">
      <xsl:value-of select="name"/>
      <span class="product-category">
        <xsl:value-of select="category"/>
      </span>
    </div>
    
    <div class="card-detail">
      <span>Price:</span> $<xsl:value-of select="price"/>
    </div>
    
    <div class="card-detail">
      <span>Stock:</span> <xsl:value-of select="stock"/>
    </div>
    
    <div class="card-detail">
      <span>Description:</span> <xsl:value-of select="description"/>
    </div>
  </div>
</xsl:template>

</xsl:stylesheet>