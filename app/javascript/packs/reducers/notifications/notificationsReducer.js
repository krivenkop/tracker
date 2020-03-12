import {
  ADD_NOTIFICATION,
  REMOVE_NOTIFICATION, SET_HIDING,
} from '../../actions/notifications/types';
import sluggify from '../../services/sluggify';

const initialState = {
  list: [],
};

export default (state = initialState, action = {}) => {
  switch (action.type) {
    case ADD_NOTIFICATION:
      return {
        ...state,
        list: [
          ...state.list,
          {
            title: action.payload.title,
            slug: action.payload.slug,
            hiding: false,
          },
        ],
      };

    case REMOVE_NOTIFICATION:
      return {
        ...state,
        list: state.list.filter(
          (el) => el.slug !== action.payload,
        ),
      };

    case SET_HIDING:
      return {
        ...state,
        list: state.list.map((el) => {
          if (el.slug === action.payload) {
            return { ...el, hiding: true };
          }

          return el;
        }),
      };

    default: return { ...state };
  }
};
