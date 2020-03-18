import Authentication from '../../services/aunthetication';
import {
  UPDATE_JWT_PAYLOAD,
  UPDATE_ACCESS_TOKEN,
  UPDATE_REFRESH_TOKEN, DESTROY_AUTH,
} from '../../actions/auth/types';

const initialState = {
  profile: {},
  jwt: { access: null, refresh: null },
};

export default (state = initialState, action = {}) => {
  switch (action.type) {
    case UPDATE_ACCESS_TOKEN: {
      const auth = new Authentication(action.payload);

      return {
        ...state,
        jwt: {
          ...state.jwt,
          access: {
            token: auth.accessToken,
            header: auth.accessHeader,
          },
        },
      };
    }

    case UPDATE_REFRESH_TOKEN: {
      const auth = new Authentication(action.payload);

      return {
        ...state,
        jwt: {
          ...state.jwt,
          refresh: {
            token: auth.refreshToken,
            expiredOn: auth.refreshExpires,
          },
        },
      };
    }

    case UPDATE_JWT_PAYLOAD:
      return {
        ...state,
        profile: action.payload.user.user,
      };

    case DESTROY_AUTH:
      return {
        ...state,
        profile: {},
        jwt: {
          access: null,
          refresh: null,
        },
      };

    default: return { ...state };
  }
};
