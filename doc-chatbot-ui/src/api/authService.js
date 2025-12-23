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

class AuthService {
  constructor() {
    this.token = null;
    this.tokenExpiry = null;
  }

  async getAccessToken() {
    if (this.token && this.tokenExpiry && new Date() < this.tokenExpiry) {
      return this.token;
    }

    try {
      const response = await fetch(process.env.REACT_APP_OAUTH_TOKEN_URL, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': `Basic ${process.env.REACT_APP_OAUTH_CLIENT_CREDENTIALS}`
        },
        body: 'grant_type=client_credentials'
      });

      if (response.ok) {
        const data = await response.json();
        if (data.access_token) {
          this.token = data.access_token;
          const expiresIn = data.expires_in || 3600;
          this.tokenExpiry = new Date(Date.now() + (expiresIn - 60) * 1000);
          return this.token;
        }
      }
    } catch (error) {
      console.error('Auth error:', error);
    }
    
    return null;
  }

  clearToken() {
    this.token = null;
    this.tokenExpiry = null;
  }
}

// Create and export a singleton instance
const authService = new AuthService();
export default authService;