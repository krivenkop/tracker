import jwtDecode from 'jwt-decode';

export default class {
  constructor(tokens) {
    this.accessToken = tokens.access;
    this.accessHeader = jwtDecode(tokens.access, { header: true });
    this.accessPayload = jwtDecode(tokens.access);

    this.refreshToken = tokens.refresh.token;
    this.refreshExpires = tokens.refresh.expires_on;
  }
}