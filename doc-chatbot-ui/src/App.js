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

import './App.css';
import ChatUI from './components/ChatUI';
import { useEffect } from 'react';

function App() {
  useEffect(() => {
    // Function to apply theme to the body element
    const applyTheme = (isDark) => {
      if (isDark) {
        document.body.setAttribute('data-md-color-scheme', 'slate');
      } else {
        document.body.setAttribute('data-md-color-scheme', 'default');
      }
    };

    // Check if we're in an iframe
    const isInIframe = window.self !== window.top;

    if (isInIframe) {
      // Listen for theme messages from parent
      const handleMessage = (event) => {
        if (event.data && event.data.type === 'theme-change') {
          applyTheme(event.data.isDark);
        }
      };

      window.addEventListener('message', handleMessage);

      // Request initial theme from parent
      try {
        window.parent.postMessage({ type: 'theme-request' }, '*');
      } catch (e) {
        console.log('Could not communicate with parent frame');
      }

      // Also detect theme from parent if possible
      try {
        const parentScheme = window.parent.document.body.getAttribute('data-md-color-scheme');
        if (parentScheme) {
          applyTheme(parentScheme === 'slate');
        }
      } catch (e) {
        // Cross-origin, can't access parent directly
        console.log('Cross-origin restriction, using postMessage for theme sync');
      }

      return () => {
        window.removeEventListener('message', handleMessage);
      };
    } else {
      // Not in iframe, use system preference
      const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
      applyTheme(prefersDark);

      const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
      const handleChange = (e) => applyTheme(e.matches);
      mediaQuery.addEventListener('change', handleChange);

      return () => mediaQuery.removeEventListener('change', handleChange);
    }
  }, []);

  return (
    <div className="App">
      <ChatUI />
    </div>
  );
}

export default App;
