/**
 * Authentication service for WSO2 OAuth2 token generation
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