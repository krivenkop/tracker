import React from 'react';

export default () => {
  const processSubmit = (e) => {
    e.preventDefault();
  };

  return (
    <div className="login-form__wrapper">
      <form action="/login" className="login-form" onSubmit={processSubmit}>
        <h1 className="login-form__title">Login</h1>

        <div className="form__group">
          <label htmlFor="username" className="form__label">Username</label>
          <input type="text" className="login-form__username form__string"
                 name="username" id="username" />
        </div>

        <div className="form__group">
          <label htmlFor="password" className="form__label">Password</label>
          <input type="password" className="login-form__password form__string"
                 name="password" id="password" />
        </div>

        <div className="d-flex justify-content-center">
          <button className="login-form__submit form__submit">Войти</button>
        </div>
      </form>
    </div>
  );
};
