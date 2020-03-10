import React from 'react';

export default () => {
  const processSubmit = (e) => {
    e.preventDefault();
  };

  return (
    <div className="login-form__wrapper">
      <form action="/login" className="login-form" onSubmit={processSubmit}>
        <input type="text" className="login-form__username"/>
        <input type="password" className="login-form__password"/>

        <button className="login-form__submit">Войти</button>
      </form>
    </div>
  );
};
