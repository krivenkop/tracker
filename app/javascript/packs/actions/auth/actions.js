import {
  UPDATE_ACCESS_TOKEN,
  UPDATE_REFRESH_TOKEN,
  UPDATE_JWT_PAYLOAD,
  DESTROY_AUTH,
  VERIFY_AUTH,
} from './types';

export const updateAccessToken = (payload) => ({
  type: UPDATE_ACCESS_TOKEN,
  payload,
});

export const updateRefreshToken = (payload) => ({
  type: UPDATE_REFRESH_TOKEN,
  payload,
});

export const updateJWTPayload = (payload) => ({
  type: UPDATE_JWT_PAYLOAD,
  payload,
});

export const destroyAuth = () => ({
  type: DESTROY_AUTH,
});

export const verifyAuth = () => ({
  type: VERIFY_AUTH,
});
