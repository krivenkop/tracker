import React from 'react';
import { connect } from 'react-redux';

import Guest from './Guest';
import Notifications from '../components/notifications';
import {
  addNotification,
  removeNotification,
  setHiding,
} from '../actions/notifications';

class App extends React.Component {
  render = () => (
    <div className="h-100">
      <Guest addNotification={this.props.notificationsActions.addNotification}/>
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
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(App);
