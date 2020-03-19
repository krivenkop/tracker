import React, { useState } from 'react';

import Authentication from '../../services/aunthetication';
import signinRequest from '../../requests/signin';
import Validator from '../../validators';
import FormsHelper from '../../services/forms';
import sluggify from '../../services/sluggify';

export default (props) => {
  const [email, setEmail] = useState(FormsHelper.defaultInputState);
  const [password, setPassword] = useState(FormsHelper.defaultInputState);

  const emailValidator = new Validator('email|required');
  const passwordValidator = new Validator('required');

  const successMessage = 'You have successfully authenticated!';
  const invalidMessage = 'Invalid credentials!';

  const validateEmail = () => {
    const { valid, errors } = emailValidator.validate(email.value, 'email');
    setEmail({ ...email, valid, errors });
  };

  const validatePassword = () => {
    const { valid, errors } = passwordValidator.validate(password.value, 'password');
    setPassword({ ...password, valid, errors });
  };

  const processSubmit = async (e) => {
    e.preventDefault();

    if (FormsHelper.isInputsAnyInvalid([email, password])) {
      validateEmail();
      validatePassword();

      return;
    }

    try {
      const res = await signinRequest({
        email: email.value,
        password: password.value,
      });

      const auth = new Authentication(res.data);

      props.authActions.updateAccessToken({ access: res.data.access });
      props.authActions.updateRefreshToken({ refresh: res.data.refresh });
      props.authActions.updateUserPayload({
        user: auth.accessPayload,
      });

      props.addNotification({
        title: successMessage,
        slug: sluggify(successMessage),
      });
    } catch (err) {
      props.addNotification({
        title: invalidMessage,
        slug: sluggify(invalidMessage),
      });
    }
  };

  return (
    <div className="login-form__wrapper">
      <form action="#" className="login-form" onSubmit={processSubmit}>
        <h1 className="login-form__title">Login</h1>

        <div className="form__group">
          <label htmlFor="username" className="form__label">Email</label>
          <input type="text" className={`login-form__username form__string ${FormsHelper.renderErrorClass(email)}`}
                 name="username" id="username" value={email.value} onBlur={validateEmail}
                 onChange={(e) => FormsHelper.updateValue(e.target.value, email, setEmail)} />
          <div className="form__errors">
            {email.errors.map((el, index) => <p className="form__error" key={index}>{el}</p>)}
          </div>
        </div>

        <div className="form__group">
          <label htmlFor="password" className="form__label">Password</label>
          <input type="password" className={`login-form__password form__string ${FormsHelper.renderErrorClass(password)}`}
                 name="password" id="password" value={password.value} onBlur={validatePassword}
                 onChange={(e) => FormsHelper.updateValue(e.target.value, password, setPassword)} />
          <div className="form__errors">
            {password.errors.map((el, index) => <p className="form__error" key={index}>{el}</p>)}
          </div>
        </div>

        <div className="d-flex justify-content-center">
          <button className="login-form__submit form__submit">Log in</button>
        </div>
      </form>
    </div>
  );
};
