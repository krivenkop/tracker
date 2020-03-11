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
  render = (props) => (
    <Router>
      <Header />

      <Switch>
        <Route path="/register">
          <Register addNotification={this.addNotification} />
        </Route>
        <Route path="/" component={Login} />
      </Switch>
    </Router>
  );

  addNotification = (text) => {
    console.log(text);
  }
}

export default Guest;
