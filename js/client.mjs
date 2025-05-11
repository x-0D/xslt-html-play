/**
 * client.mjs - Client-side JavaScript for B2C CRM System
 * Handles tab switching and XML data loading without page reloads
 */

// Store references to DOM elements
const tabButtons = document.querySelectorAll('.tab-button');
const tabContents = document.querySelectorAll('.tab-content');

// XML data sources
const xmlSources = {
  customers: 'xmls/customers.xml',
  leads: 'xmls/leads.xml',
  inventory: 'xmls/inventory.xml'
};

// XML files contain their own stylesheet references via xml-stylesheet processing instructions

// Default active tab
let activeTab = 'customers';

// Initialize the application
document.addEventListener('DOMContentLoaded', () => {
  // Set up tab button click handlers
  tabButtons.forEach(button => {
    button.addEventListener('click', () => {
      const tabName = button.getAttribute('data-tab');
      switchTab(tabName);
    });
  });

  // Load the default tab
  switchTab(activeTab);
});

/**
 * Switch to the specified tab and load its data
 * @param {string} tabName - The name of the tab to switch to
 */
function switchTab(tabName) {
  // Update active tab
  activeTab = tabName;
  
  // Update tab button states
  tabButtons.forEach(button => {
    if (button.getAttribute('data-tab') === tabName) {
      button.classList.add('active');
    } else {
      button.classList.remove('active');
    }
  });
  
  // Update tab content visibility
  tabContents.forEach(content => {
    if (content.id === `${tabName}-tab`) {
      content.classList.add('active');
    } else {
      content.classList.remove('active');
    }
  });
  
  // Load the XML data for the active tab
  loadXMLData(tabName);
}

/**
 * Load and transform XML data for the specified tab
 * @param {string} tabName - The name of the tab to load data for
 */
async function loadXMLData(tabName) {
  try {
    const contentContainer = document.getElementById(`${tabName}-tab`);
    
    // Show loading indicator
    contentContainer.innerHTML = '<div class="loading">Loading data...</div>';
    
    // Fetch the XML data
    const xmlResponse = await fetch(xmlSources[tabName]);
    const xmlText = await xmlResponse.text();
    const xmlDoc = new DOMParser().parseFromString(xmlText, 'text/xml');
    
    // Extract the stylesheet reference from the XML processing instruction
    const stylesheetPI = Array.from(xmlDoc.childNodes)
      .find(node => node.nodeType === 7 && node.target === 'xml-stylesheet');
    
    if (!stylesheetPI) {
      throw new Error('No xml-stylesheet processing instruction found in the XML file');
    }
    
    // Parse the href attribute from the processing instruction
    const hrefMatch = stylesheetPI.data.match(/href=["']([^"']+)["']/);
    if (!hrefMatch) {
      throw new Error('No href attribute found in xml-stylesheet processing instruction');
    }
    
    // Get the stylesheet path and remove leading slash if present
    let stylesheetHref = hrefMatch[1];
    if (stylesheetHref.startsWith('/')) {
      stylesheetHref = stylesheetHref.substring(1);
    }
    
    // Fetch the XSLT stylesheet
    const xsltResponse = await fetch('xmls/'+stylesheetHref);
    const xsltText = await xsltResponse.text();
    const xsltDoc = new DOMParser().parseFromString(xsltText, 'text/xml');
    
    // Perform the transformation
    const processor = new XSLTProcessor();
    processor.importStylesheet(xsltDoc);
    // Set load_stylesheet parameter to false to avoid data consumption
    processor.setParameter(null, 'load_stylesheet', 'false');
    
    const resultFragment = processor.transformToFragment(xmlDoc, document);
    
    // Update the content container
    contentContainer.innerHTML = '';
    contentContainer.appendChild(resultFragment);
  } catch (error) {
    console.error(`Error loading ${tabName} data:`, error);
    document.getElementById(`${tabName}-tab`).innerHTML = 
      `<div class="error">Error loading data: ${error.message}</div>`;
  }
}