import {
  takeEvery, put, call, select, all,
} from 'redux-saga/effects';
import axios from 'axios';
import { destroyAuth, updateAccessToken } from '../actions/auth';
import { VERIFY_AUTH } from '../actions/auth/types';

const unixTime = new Date().getTime() / 1000;

const isRefreshTokenExists = (state) => !!state.user.jwt.refresh;
const isAccessTokenExists = (state) => !!state.user.jwt.access;

const isRefreshTokenExpired = (state) => state.user.jwt.refresh.expiredOn <= unixTime;
const isAccessTokenExpired = (state) => state.user.jwt.access.header.exp <= unixTime;

const refreshTokenFromState = (state) => state.user.jwt.refresh.token;

function fetchNewAccessToken(refreshToken) {
  return axios.post('/update-access-token', { refresh_token: refreshToken });
}

function* workerVerifyAuth() {
  const isRefreshExists = yield select(isRefreshTokenExists);
  const isAccessExists = yield select(isAccessTokenExists);

  if (!isRefreshExists || !isAccessExists) return;

  const isRefreshExpired = yield select(isRefreshTokenExpired);
  const isAccessExpired = yield select(isAccessTokenExpired);

  if (isRefreshExpired) {
    yield put(destroyAuth());
  } else if (isAccessExpired) {
    const refreshToken = yield select(refreshTokenFromState);
    try {
      const res = yield call(fetchNewAccessToken, refreshToken);
      yield put(updateAccessToken({ access: res.data.access }));
    } catch (e) {
      console.log('Error', e);
      yield put(destroyAuth());
    }
  }
}

function* watchVerifyAuth() {
  yield takeEvery(VERIFY_AUTH, workerVerifyAuth);
}

export default function* () {
  yield all([
    watchVerifyAuth(),
  ]);
}
