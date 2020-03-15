import React from 'react';
import { connect } from 'react-redux';

import Guest from './Guest';
import Notifications from '../components/notifications';
import {
  addNotification,
  removeNotification,
  setHiding,
} from '../actions/notifications';
import {
  updateAccessToken,
  updateRefreshToken,
  updateJWTPayload,
} from '../actions/auth';

class App extends React.Component {
  render = () => (
    <div className="h-100">
      <Guest addNotification={this.props.notificationsActions.addNotification}
            authActions={this.props.authActions}/>
      <Notifications notifications={this.props.notifications.list}
                     actions={this.props.notificationsActions}/>
    </div>
  )
}

const mapStateToProps = (state) => {
  return {
    user: state.user,
    notifications: state.notifications,
  };
};

const mapDispatchToProps = (dispatch) => {
  return {
    notificationsActions: {
      addNotification: (payload) => {
        dispatch(addNotification(payload));
      },
      removeNotification: (payload) => {
        dispatch(removeNotification(payload));
      },
      setHiding: (payload) => {
        dispatch(setHiding(payload));
      },
    },
    authActions: {
      updateAccessToken: (payload) => {
        dispatch(updateAccessToken(payload));
      },
      updateRefreshToken: (payload) => {
        dispatch(updateRefreshToken(payload));
      },
      updateUserPayload: (payload) => {
        dispatch(updateJWTPayload(payload));
      },
    },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(App);
