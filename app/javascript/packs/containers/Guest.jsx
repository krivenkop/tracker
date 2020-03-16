import React from 'react';
import {
  BrowserRouter as Router,
  Switch,
  Route,
} from 'react-router-dom';

import Header from '../components/Header';
import Login from '../components/pages/Login';
import Register from '../components/pages/Register';

class Guest extends React.Component {
  render = () => {
    window.addNotification = this.props.addNotification;
    return (<Router>
      <Header/>

      <Switch>
        <Route path="/register">
          <Register addNotification={this.props.addNotification} />
        </Route>
        <Route path="/">
          <Login authActions={this.props.authActions}
                 addNotification={this.props.addNotification} />
        </Route>
      </Switch>
    </Router>);
  };
}

export default Guest;
