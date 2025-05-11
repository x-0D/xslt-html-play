<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes"/>

<!-- This stylesheet handles the transformation of XML data for the CRM system -->
<!-- It supports client-side tab switching without page reloads -->

<!-- Template for the root element -->
<xsl:template match="/">
  <html>
  <head>
    <title>B2C CRM System</title>
    <link rel="stylesheet" href="../styles/style.css"/>
    <script type="module" src="js/client.mjs"></script>
  </head>
  <body>
    <header>
      <h1>B2C CRM System</h1>
    </header>
    
    <nav class="tab-navigation">
      <button class="tab-button" data-tab="customers">Customers</button>
      <button class="tab-button" data-tab="leads">Leads</button>
      <button class="tab-button" data-tab="inventory">Inventory</button>
    </nav>
    
    <main id="content-container">
      <!-- Content will be dynamically loaded here via JavaScript -->
      <div id="customers-tab" class="tab-content">
        <!-- Customer data will be loaded here -->
      </div>
      
      <div id="leads-tab" class="tab-content">
        <!-- Lead data will be loaded here -->
      </div>
      
      <div id="inventory-tab" class="tab-content">
        <!-- Inventory data will be loaded here -->
      </div>
    </main>
    
    <footer>
      <p>B2C CRM System - SOAP with XML and XSLT</p>
    </footer>
  </body>
  </html>
</xsl:template>

</xsl:stylesheet>