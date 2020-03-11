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
  render = (store) => (
    <Router>
      <Header />

      <Switch>
        <Route path="/register" component={Register} />
        <Route path="/" component={Login} />
      </Switch>
    </Router>
  );
}

export default Guest;
