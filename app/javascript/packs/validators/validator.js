import email from './email';
import required from './required';
import passwordMatch from './password-match';
import minLength from './min-length';
import maxLength from './max-length';

export default class {
  constructor(rules) {
    this.rules = this.parseRules(rules);

    this.validators = {
      email,
      required,
      passwordMatch,
      minLength,
      maxLength,
    };
  }

  validate = (value, fieldName) => {
    let valid = true;
    let errors = [];

    this.rules.forEach((rule) => {
      const validation = rule.params ? this.validators[rule.name](value, rule.params)
        : this.validators[rule.name](value);

      if (!validation.valid) {
        valid = false;
        errors = [...errors, ...this.processValidationErrors(validation.errors, fieldName)];
      }
    });

    return { valid, errors };
  }

  updateRules = (rules) => {
    this.rules = this.parseRules(rules);
  }

  parseRules = (rules) => {
    const rulesArr = rules.split('|');

    return rulesArr.map((el) => {
      const splitted = el.split(':');

      return { name: splitted[0], params: splitted[1] };
    });
  };

  processValidationErrors = (errors, fieldName) => {
    if (!errors) return [];

    return errors.map((el) => {
      const replaced = el.replace(':field:', fieldName);
      return replaced.charAt(0).toUpperCase() + replaced.slice(1);
    });
  }
}
