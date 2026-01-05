/**
 * Copyright (c) 2023-2025, WSO2 LLC. (https://www.wso2.com).
 *
 * WSO2 LLC. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

// Initialize version dropdown
function initVersionDropdown() {
  const dropdown = document.querySelector('.md-header__version-select-dropdown');
  
  if (dropdown) {
    // Add a click event listener to the dropdown link
    const dropdownLink = dropdown.querySelector('.dropdown-link');

    if (dropdownLink) {
      // Remove any existing event listeners by cloning
      const newDropdownLink = dropdownLink.cloneNode(true);
      dropdownLink.parentNode.replaceChild(newDropdownLink, dropdownLink);
      
      newDropdownLink.addEventListener('click', function(event) {
        event.preventDefault();
        event.stopPropagation();
        dropdown.classList.toggle('open');
      });
    }

    // Add a click event listener to close dropdown when clicking outside
    document.addEventListener('click', function(event) {
      if (!dropdown.contains(event.target)) {
        dropdown.classList.remove('open');
      }
    });
  }
}

// Run after DOM is ready - single initialization only
if (typeof window.versionDropdownInitialized === 'undefined') window.versionDropdownInitialized = false;
document.addEventListener('DOMContentLoaded', function() {
  if (!window.versionDropdownInitialized) {
    initVersionDropdown();
    window.versionDropdownInitialized = true;
  }
});

// Wrap tabbed content and nav items in DOMContentLoaded
document.addEventListener('DOMContentLoaded', function() {
  // Add a class to content tabs that has multiple child elements rather than a code block
  document.querySelectorAll('.tabbed-content').forEach(tabbedContent => {
    const tabbedBlocks = Array.from(tabbedContent.querySelectorAll('.tabbed-block'));
    
    // Check if each .tabbed-block has more than 1 child or if its immediate child is not .highlight
    const shouldAddClass = tabbedBlocks.some(tabbedBlock => 
      tabbedBlock.children.length > 1 || !tabbedBlock.firstElementChild.classList.contains('highlight')
    );

    if (shouldAddClass) {
      tabbedContent.classList.add('tab_with_no_code');
    }
  });

  // Toggle active state of nested nav items
  const activeNavItems = document.querySelectorAll('.md-nav__list > .md-nav__item.md-nav__item--active.md-nav__item--nested');
  
  if (activeNavItems) {
    activeNavItems.forEach((item) => {
      const checkbox = item.querySelector('input[type="checkbox"].md-nav__toggle.md-toggle');
      
      if (checkbox) {
        checkbox.checked = true;
      }
    });
  }
});

/*
 * Handle opening external links in a new tab
 * and initialize JSON tree formatter
 */
document.addEventListener('DOMContentLoaded', function() {
  // Open external links in new tab
  var links = document.links;
  for (var i = 0, linksLength = links.length; i < linksLength; i++) {
    if (links[i].hostname != window.location.hostname) {
      links[i].target = "_blank";
      links[i].setAttribute("rel", "noopener noreferrer");
      links[i].className += " externalLink";
    } else {
      links[i].className += " localLink";
    }
  }
  
  // Initialize JSON tree formatter
  var jsonTreeInputs = document.getElementsByClassName('jsonTreeInput');
  if (jsonTreeInputs && jsonTreeInputs.length > 0) {
    for (var i = 0; i < jsonTreeInputs.length; i++) {
      try {
        var jsonTreeInput = jsonTreeInputs[i];
        var jsonTreeOutput = jsonTreeInput.previousElementSibling;
        var level = jsonTreeInput.getAttribute('data-level');
        var levelInteger = level ? parseInt(level) : 1;
        var formatter = new JSONFormatter(JSON.parse(jsonTreeInput.innerHTML), levelInteger, { hoverPreviewEnabled: false });
        jsonTreeOutput.innerHTML = '';
        jsonTreeOutput.appendChild(formatter.render());
        jsonTreeInput.style.display = 'none';
      } catch (e) {
        console.error(e);
      }
    }
  }
});

// Set last vsited valid page in session storage
window.addEventListener("DOMContentLoaded", function () {
  fetch(window.location.href, {
    method: "GET",
    headers: {
      "Content-Type": "application/json",
    },
  }).then((response) => {
    if (response.status !== 404) {
      sessionStorage.setItem("lastValidPage", window.location.href);
    }
  });
});

/* 
 * Reading versions
 */
if (typeof window.versionsLoaded === 'undefined') window.versionsLoaded = false;
window.addEventListener('DOMContentLoaded', function() {
  if (window.versionsLoaded) return;
  window.versionsLoaded = true;
  
  var pageHeader = document.getElementById('page-header');
  var docSetLang = pageHeader.getAttribute('data-lang') == null ? 'en' : pageHeader.getAttribute('data-lang');

  (window.location.pathname.split('/')[1] !== docSetLang) ? 
      docSetLang = '' :
      docSetLang = docSetLang + '/';

  var docSetUrl = window.location.origin + '/' + docSetLang;
  
  // Try to load from local first, fallback to remote
  var versionsUrl = docSetUrl + '4.6.0/versions/assets/versions.json';
  
  var request = new XMLHttpRequest();

  request.open('GET', versionsUrl, true);
  
  // Add error handler
  request.onerror = function() {
    console.error("Failed to load versions.json. CORS or network error.");
    // For development, you can add mock data here
    console.log("You can create a local versions.json file at: /en/versions/assets/versions.json");
  };

  request.onload = function() {
    if (request.status >= 200 && request.status < 400) {

        var data = JSON.parse(request.responseText);
      var dropdown =  document.getElementById('version-select-dropdown');
      var checkVersionsPage = document.getElementById('current-version-stable');
      
      /* 
       * Appending versions to the version selector dropdown 
       */
      if (dropdown){
          data.list.sort().forEach(function(key, index){
              var versionData = data.all[key];
              
              if(versionData) {
                  var liElem = document.createElement('li');
                  var docLinkType = data.all[key].doc.split(':')[0];
                  var target = '_self';
                  var url = data.all[key].doc;

                  if ((docLinkType == 'https') || (docLinkType == 'http')) {
                      target = '_blank'
                  }
                  else {
                      url = docSetUrl + url;
                  }
                  liElem.innerHTML =  '<a href="' + url + '" target="' + 
                      target + '">' + key + '</a>';

                  dropdown.insertBefore(liElem, dropdown.firstChild);
              }
          });

          document.getElementById('show-all-versions-link')
              .setAttribute('href', docSetUrl + 'versions');
      }
      
      /* 
       * Appending versions to the version tables in versions page
       */
      if (checkVersionsPage){
          var previousVersions = [];

          Object.keys(data.all).forEach(function(key, index){
              if ((key !== data.current) && (key !== data['pre-release'])) {
                  var docLinkType = data.all[key].doc.split(':')[0];
                  var target = '_self';

                  if ((docLinkType == 'https') || (docLinkType == 'http')) {
                      target = '_blank'
                  }

                  previousVersions.push('<tr>' +
                    '<th>' + key + '</th>' +
                        '<td>' +
                            '<a href="' + data.all[key].doc + '" target="' + 
                                target + '">Documentation</a>' +
                        '</td>' +
                        '<td>' +
                            '<a href="' + data.all[key].notes + '" target="' + 
                                target + '">Release Notes</a>' +
                        '</td>' +
                    '</tr>');
              }
          });

          // Past releases update
          document.getElementById('previous-versions').innerHTML = 
                  previousVersions.join(' ');

          // Current released version update
          document.getElementById('current-version-number').innerHTML = 
                  data.current;
          document.getElementById('current-version-documentation-link')
                  .setAttribute('href', docSetUrl + data.all[data.current].doc);
          document.getElementById('current-version-release-notes-link')
                  .setAttribute('href', docSetUrl + data.all[data.current].notes);
        
          // Pre-release version update
          document.getElementById('pre-release-version-documentation-link')
              .setAttribute('href', docSetUrl + 'next/');
      }
      
  } else {
      console.error("We reached our target server, but it returned an error");
  }
  };

  request.send();
});

