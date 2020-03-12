import { combineReducers } from 'redux';
import notificationsReducer from './notifications/notificationsReducer';
import userReducer from './user/userReducer';

export default combineReducers({
  notifications: notificationsReducer,
  user: userReducer,
});
