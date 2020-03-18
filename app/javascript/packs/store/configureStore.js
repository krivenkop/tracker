import { createStore, applyMiddleware } from 'redux';
import createSagaMiddleware from 'redux-saga';
import logger from 'redux-logger';

import rootReducer from '../reducers/rootReducer';
import rootNotificationsSagas from '../sagas/notificationsSagas';
import rootAuthenticationSagas from '../sagas/authenticationSagas';

export default function configureStore(initialState = {}) {
  const sagaMiddleware = createSagaMiddleware();
  const store = createStore(rootReducer, initialState, applyMiddleware(sagaMiddleware, logger));

  store.subscribe(() => {
    localStorage.setItem('reduxState', JSON.stringify(store.getState()));
  });

  sagaMiddleware.run(rootNotificationsSagas);
  sagaMiddleware.run(rootAuthenticationSagas);

  return store;
}
