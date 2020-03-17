import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import React from 'react';

import App from './containers/App';
import configureStore from './store/configureStore';
import stateFromLocalStorage from './services/stateFromLocalStorage';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Provider store={configureStore(stateFromLocalStorage())}>
      <App />
    </Provider>,
    document.querySelector('.application'),
  );
});
