import React, { useState } from 'react';

import signupRequest from '../../requests/signup';
import Validator from '../../validators/validator';
import FormsHelper from '../../services/forms';
import sluggify from '../../services/sluggify';

export default (props) => {
  const [email, setEmail] = useState(FormsHelper.defaultInputState);
  const [password, setPassword] = useState(FormsHelper.defaultInputState);
  const [passwordConfirmation, setPasswordConfirmation] = useState(FormsHelper.defaultInputState);

  const emailValidator = new Validator('email');
  const passwordValidator = new Validator('required|minLength:6|maxLength:20');
  const passwordConfirmationValidator = new Validator('required');

  const successMessage = 'You have registered successful! <br> Try to login';

  const validateEmail = () => {
    const { valid, errors } = emailValidator.validate(email.value, 'email');
    setEmail({ ...email, valid, errors });
  };

  const validatePassword = () => {
    const { valid, errors } = passwordValidator.validate(password.value, 'password');
    setPassword({ ...password, valid, errors });
  };

  const validatePasswordConfirmation = () => {
    passwordConfirmationValidator.updateRules(`required|passwordMatch:${password.value}`);

    const { valid, errors } = passwordConfirmationValidator
      .validate(passwordConfirmation.value, 'password confirmation');
    setPasswordConfirmation({ ...passwordConfirmation, valid, errors });
  };

  const processSubmit = async (e) => {
    e.preventDefault();

    if (FormsHelper.isInputsAnyInvalid([email, password, passwordConfirmation])) {
      validateEmail();
      validatePassword();
      validatePasswordConfirmation();

      return;
    }

    const res = await signupRequest({
      email: email.value,
      password: password.value,
      passwordConfirmation: passwordConfirmation.value,
    });

    if (!res.data.errors) {
      props.addNotification({
        title: successMessage,
        slug: sluggify(successMessage),
      });
    }
  };

  return (
    <div className="register-form__wrapper">
      <form action="#" className="register-form" onSubmit={processSubmit}>
        <h1 className="register-form__title">Register</h1>

        <div className="form__group">
          <label htmlFor="email" className="form__label">Email</label>
          <input type="text"
                 className={`register-form__email form__string ${FormsHelper.renderErrorClass(email)}`}
                 name="email" id="email" value={email.value} onBlur={validateEmail}
                 onChange={(e) => FormsHelper.updateValue(e.target.value, email, setEmail)}/>
          <div className="form__errors">
            {email.errors.map((el, index) => <p className="form__error" key={index}>{el}</p>)}
          </div>
        </div>

        <div className="form__group">
          <label htmlFor="password" className="form__label">Password</label>
          <input type="password" onBlur={validatePassword}
                 className={`register-form__password form__string ${FormsHelper.renderErrorClass(password)}`}
                 name="password" id="password" value={password.value}
                 onChange={(e) => FormsHelper.updateValue(e.target.value, password, setPassword)}/>
          <div className="form__errors">
            {password.errors.map((el, index) => <p className="form__error" key={index}>{el}</p>)}
          </div>
        </div>

        <div className="form__group">
          <label htmlFor="password" className="form__label">Password Confirmation</label>
          <input type="password"
                 className={`register-form__password-confirmation form__string 
                 ${FormsHelper.renderErrorClass(passwordConfirmation)}`}
                 onBlur={validatePasswordConfirmation}
                 name="password-confirmation" id="password-confirmation"
                 value={passwordConfirmation.value}
                 onChange={(e) => FormsHelper.updateValue(
                   e.target.value,
                   passwordConfirmation,
                   setPasswordConfirmation,
                 )}/>
          <div className="form__errors">
            {passwordConfirmation.errors
              .map((el, index) => <p className="form__error" key={index}>{el}</p>)}
          </div>
        </div>

        <div className="d-flex justify-content-center">
          <button className="register-form__submit form__submit">Register</button>
        </div>
      </form>
    </div>
  );
};
