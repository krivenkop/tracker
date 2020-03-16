import axios from 'axios';

import authToken from '../services/authenticityToken';

export default async (data) => {
  const { email, password } = data;

  return axios.post('/login.json', {
    user: {
      email,
      password,
    },
  }, {
    headers: {
      'X-CSRF-Token': authToken(),
    },
  });
};
