import React from 'react';
import { connect } from 'react-redux';

class App extends React.Component {
  render = () => (
    <h1>Hello world</h1>
  );
}

function mapStateToProps(state) {
  return {};
}

export default connect(mapStateToProps)(App);
