export default (value, minLength) => {
  if (value.length >= minLength) {
    return { valid: true };
  }

  return { valid: false, errors: [`:field: need have minimum ${minLength} symbols`] };
};
