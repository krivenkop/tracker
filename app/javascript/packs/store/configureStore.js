import { createStore, applyMiddleware } from 'redux';
import createSagaMiddleware from 'redux-saga';
import logger from 'redux-logger';

import rootReducer from '../reducers/rootReducer';
import rootNotificationsSaga from '../sagas/notificationsSagas';

export default function configureStore(initialState = {}) {
  const sagaMiddleware = createSagaMiddleware();
  const store = createStore(rootReducer, initialState, applyMiddleware(sagaMiddleware, logger));

  sagaMiddleware.run(rootNotificationsSaga);

  return store;
}
