import axios from 'axios';

import authToken from '../services/authenticityToken';

export default async (data) => {
  const { email, password, passwordConfirmation } = data;

  return axios.post('/signup', {
    email,
    password,
    password_confirmation: passwordConfirmation,
  }, {
    headers: {
      'X-CSRF-Token': authToken(),
    },
  });
};
