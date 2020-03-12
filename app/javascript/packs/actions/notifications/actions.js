import {
  ADD_NOTIFICATION,
  REMOVE_NOTIFICATION,
  SET_HIDING,
} from './types';

export const addNotification = (payload) => ({
  type: ADD_NOTIFICATION,
  payload,
});

export const removeNotification = (payload) => ({
  type: REMOVE_NOTIFICATION,
  payload,
});

export const setHiding = (payload) => {
  return {
    type: SET_HIDING,
    payload,
  };
};
