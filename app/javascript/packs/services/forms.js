export default class {
  static isInputDanger = (input) => {
    return !input.valid && input.touched;
  }

  static isNotInputDanger = (input) => {
    return !this.isInputDanger(input);
  }

  static isInputValid = (input) => {
    return input.valid;
  }

  static isInputInvalid = (input) => {
    return !this.isInputValid(input);
  }

  static isInputsAllValid = (inputs) => {
    let result = true;
    // eslint-disable-next-line consistent-return
    inputs.forEach((input) => {
      if (this.isInputInvalid(input)) {
        result = false;
      }
    });

    return result;
  }

  static isInputsAnyInvalid = (inputs) => {
    let result = false;
    // eslint-disable-next-line consistent-return
    inputs.forEach((input) => {
      if (this.isInputInvalid(input)) {
        result = true;
      }
    });

    return result;
  }

  static updateValue = (value, inputData, setter) => {
    setter({ ...inputData, value, touched: true });
  };

  static renderErrorClass = (input) => {
    if (this.isInputDanger(input)) return this.inputErrorClass;

    return '';
  };

  // eslint-disable-next-line class-methods-use-this
  static get defaultInputState() {
    return {
      value: '', valid: false, errors: [], touched: false,
    };
  }

  // eslint-disable-next-line class-methods-use-this
  static get inputErrorClass() {
    return 'form__string--error';
  }
}
