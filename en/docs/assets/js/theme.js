/*!
 * Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

/* 
 * Initialize custom dropdown component 
 */
var dropdowns = document.getElementsByClassName('md-tabs__dropdown-link');
var dropdownItems = document.getElementsByClassName('mb-tabs__dropdown-item');

function indexInParent(node) {
    var children = node.parentNode.childNodes;
    var num = 0;
    for (var i=0; i < children.length; i++) {
         if (children[i]==node) return num;
         if (children[i].nodeType==1) num++;
    }
    return -1;
}

for (var i = 0; i < dropdowns.length; i++) {
    var el = dropdowns[i];
    var openClass = 'open';

    el.onclick = function () {
        if (this.parentElement.classList) {
            this.parentElement.classList.toggle(openClass);
        } else {
            var classes = this.parentElement.className.split(' ');
            var existingIndex = classes.indexOf(openClass);

            if (existingIndex >= 0)
                classes.splice(existingIndex, 1);
            else
                classes.push(openClass);

            this.parentElement.className = classes.join(' ');
        }
    };
};

/* 
 * Reading versions
 */
var pageHeader = document.getElementById('page-header');
var docSetLang = pageHeader.getAttribute('data-lang');

(window.location.pathname.split('/')[1] !== docSetLang) ? 
    docSetLang = '' :
    docSetLang = docSetLang + '/';

var docSetUrl = window.location.origin + '/' + docSetLang;
var request = new XMLHttpRequest();

request.open('GET', docSetUrl +
             'versions/assets/versions.json', true);

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

                  liElem.className = 'md-tabs__item mb-tabs__dropdown';
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

request.onerror = function() {
    console.error("There was a connection error of some sort");
};

request.send();

/* 
 * Initialize highlightjs 
 */
hljs.initHighlightingOnLoad();
