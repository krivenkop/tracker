export default (value, maxLength) => {
  if (value.length <= maxLength) {
    return { valid: true };
  }

  return { valid: false, errors: [`:field: need have maximum ${maxLength} symbols`] };
};
