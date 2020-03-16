import {
  UPDATE_ACCESS_TOKEN,
  UPDATE_REFRESH_TOKEN,
  UPDATE_JWT_PAYLOAD,
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
