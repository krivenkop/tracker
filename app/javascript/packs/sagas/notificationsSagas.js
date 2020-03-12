import {
  takeEvery, put, delay, all,
} from 'redux-saga/effects';
import { ADD_NOTIFICATION, SET_HIDING } from '../actions/notifications/types';
import { removeNotification, setHiding } from '../actions/notifications';

function* workerAddNotification(action) {
  yield delay(2000);
  yield put(setHiding(action.payload.slug));
}

function* watchAddNotification() {
  yield takeEvery(ADD_NOTIFICATION, workerAddNotification);
}

function* workerSetHiding(action) {
  yield delay(1500);
  yield put(removeNotification(action.payload));
}

function* watchSetHiding() {
  yield takeEvery(SET_HIDING, workerSetHiding);
}

export default function* () {
  yield all([
    watchAddNotification(),
    watchSetHiding(),
  ]);
}
