import React from 'react';
import {
  BrowserRouter as Router,
  Switch, Route,
} from 'react-router-dom';

import UserHeader from '../components/UserHeader';
import Homepage from '../components/pages/Homepage';
import UserSidebar from '../components/UserSidebar';

class User extends React.Component {
  constructor(props) {
    super(props);
    this.state = { sidebarOpened: true };
  }

  setSidebarOpened = (status) => {
    this.setState({ sidebarOpened: status });
  }

  render = () => {
    window.setSidebarOpened = this.setSidebarOpened;
    return (
      <Router>
        <UserSidebar setSidebarOpened={this.setSidebarOpened}
                     sidebarOpened={this.state.sidebarOpened} />

        <div className={`page ${this.state.sidebarOpened ? 'page--with-sidebar' : ''}`}>
          <UserHeader profile={this.props.profile}refreshToken={this.props.jwt.refresh.token}
                      destroyAuth={this.props.authActions.destroyAuth}
                      verifyAuth={this.props.authActions.verifyAuth} />

          <Switch>
            <Route path="/">
              <Homepage addNotification={this.props.addNotification} />
            </Route>
          </Switch>
        </div>
      </Router>
    );
  };
}

export default User;
