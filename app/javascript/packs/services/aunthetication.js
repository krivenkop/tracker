import jwtDecode from 'jwt-decode';

export default class {
  constructor(tokens) {
    this.accessToken = tokens.access;
    this.accessHeader = this.accessToken ? jwtDecode(tokens.access, { header: true }) : null;
    this.accessPayload = this.accessToken ? jwtDecode(tokens.access) : null;

    this.refreshToken = tokens.refresh ? tokens.refresh.token : null;
    this.refreshExpires = tokens.refresh ? tokens.refresh.expires_on : null;
  }
}
