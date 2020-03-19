import React from 'react';
import { connect } from 'react-redux';

import Guest from './Guest';
import User from './User';
import Notifications from '../components/notifications';
import {
  addNotification, removeNotification,
  setHiding,
} from '../actions/notifications';
import {
  updateAccessToken, updateRefreshToken,
  updateJWTPayload, destroyAuth, verifyAuth,
} from '../actions/auth';

class App extends React.Component {
  componentDidMount() {
    this.props.authActions.verifyAuth();
  }

  isAuthenticated = () => {
    const unixTime = new Date().getTime() / 1000;

    if (!this.props.user.jwt.access) return false;
    if (!this.props.user.jwt.refresh) return false;

    return this.props.user.jwt.access.token
      && this.props.user.jwt.refresh.expiredOn > unixTime;
  }

  guestTemplate = () => (
    <div className="h-100">
      <Guest addNotification={this.props.notificationsActions.addNotification}
             authActions={this.props.authActions} />
      <Notifications notifications={this.props.notifications.list}
                     actions={this.props.notificationsActions} />
    </div>
  )

  userTemplate = () => (
    <div className="h-100">
      <User profile={this.props.user.profile}
            authActions={this.props.authActions}
            jwt={this.props.user.jwt} />
      <Notifications notifications={this.props.notifications.list}
                     actions={this.props.notificationsActions} />
    </div>
  )

  render = () => {
    if (this.isAuthenticated()) {
      return this.userTemplate();
    }

    return this.guestTemplate();
  }
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
      destroyAuth: () => {
        dispatch(destroyAuth());
      },
      verifyAuth: () => {
        dispatch(verifyAuth());
      },
    },
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(App);
