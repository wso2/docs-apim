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

const dropdown = document.querySelector('.md-header__version-select-dropdown');
const activeNavItems =
  document.querySelectorAll('.md-nav__list > .md-nav__item.md-nav__item--active.md-nav__item--nested');

if (dropdown) {
  // Add a click event listener to the document
  document.addEventListener('click', function(event) {
    // Check if the click event target is outside of the dropdown
    if (!dropdown.contains(event.target)) {
      dropdown.classList.remove('open'); // Hide the dropdown
    }
  });

  // Add a click event listener to the dropdown link
  const dropdownLink = dropdown.querySelector('.dropdown-link');

  dropdownLink.addEventListener('click', function(event) {
    event.preventDefault();
    event.stopPropagation(); // Prevent the event from propagating to the document
    dropdown.classList.toggle('open'); // Toggle the "open" class
  });
}

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
if (activeNavItems) {
  activeNavItems.forEach((item) => {
    const checkbox = item.querySelector('input[type="checkbox"].md-nav__toggle.md-toggle');
    
    if (checkbox) {
      checkbox.checked = true;
    }
  });
}

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
