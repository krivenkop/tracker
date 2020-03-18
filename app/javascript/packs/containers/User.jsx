import React from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from 'react-router-dom';

import UserHeader from '../components/UserHeader';
import Homepage from '../components/pages/Homepage';

class User extends React.Component {
  render = () => {
    window.addNotification = this.props.addNotification;
    return (
      <Router>
        <UserHeader profile={this.props.profile} refreshToken={this.props.jwt.refresh.token}
                    destroyAuth={this.props.authActions.destroyAuth}
                    verifyAuth={this.props.authActions.verifyAuth} />

        <Switch>
          <Route path="/">
            <Homepage addNotification={this.props.addNotification} />
          </Route>
        </Switch>
      </Router>
    );
  };
}

export default User;
