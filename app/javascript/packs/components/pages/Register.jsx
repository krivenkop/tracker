import React, { useState } from 'react';

import signupRequest from '../../requests/signup';

export default () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [passwordConfirmation, setPasswordConfirmation] = useState('');

  const processSubmit = async (e) => {
    e.preventDefault();

    const res = await signupRequest({
      email,
      password,
      passwordConfirmation,
    });

    console.log(res);
  };

  return (
    <div className="register-form__wrapper">
      <form action="#" className="register-form" onSubmit={processSubmit}>
        <h1 className="register-form__title">Register</h1>

        <div className="form__group">
          <label htmlFor="email" className="form__label">Email</label>
          <input type="text" className="register-form__email form__string"
                 name="email" id="email" value={email}
                 onChange={(e) => setEmail(e.target.value)}/>
        </div>

        <div className="form__group">
          <label htmlFor="password" className="form__label">Password</label>
          <input type="password" className="register-form__password form__string"
                 name="password" id="password" value={password}
                 onChange={(e) => setPassword(e.target.value)}/>
        </div>

        <div className="form__group">
          <label htmlFor="password" className="form__label">Password Confirmation</label>
          <input type="password"
                 className="register-form__password-confirmation form__string"
                 name="password-confirmation" id="password-confirmation"
                 value={passwordConfirmation}
                 onChange={(e) => setPasswordConfirmation(e.target.value)}/>
        </div>

        <div className="d-flex justify-content-center">
          <button className="register-form__submit form__submit">Register</button>
        </div>
      </form>
    </div>
  );
};
