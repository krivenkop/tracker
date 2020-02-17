import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import App from './containers/App';
import configureStore from './store/configureStore';
import React from 'react';

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Provider store={configureStore()}>
      <App />
    </Provider>,
    document.body.appendChild(document.createElement('div')),
  );
});
