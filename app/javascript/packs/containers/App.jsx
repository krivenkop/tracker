import React from 'react';
import { connect } from 'react-redux';

import Guest from './Guest';

class App extends React.Component {
  render = () => <Guest />;
}

function mapStateToProps(state) {
  return {
    user: state.user,
  };
}

export default connect(mapStateToProps)(App);
