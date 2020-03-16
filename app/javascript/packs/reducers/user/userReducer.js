import {
  UPDATE_JWT_PAYLOAD,
  UPDATE_ACCESS_TOKEN,
  UPDATE_REFRESH_TOKEN,
} from '../../actions/auth/types';

const initialState = {
  profile: {},
  jwt: { access: null, refresh: null },
};

export default (state = initialState, action = {}) => {
  switch (action.type) {
    case UPDATE_ACCESS_TOKEN:
      return {
        ...state,
        jwt: {
          ...state.jwt,
          access: action.payload,
        },
      };

    case UPDATE_REFRESH_TOKEN:
      return {
        ...state,
        jwt: {
          ...state.jwt,
          refresh: action.payload,
        },
      };

    case UPDATE_JWT_PAYLOAD:
      return {
        ...state,
        profile: action.payload.user,
      };

    default: return { ...state };
  }
};
