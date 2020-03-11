export default (value) => {
  if (value !== null && value !== undefined && value !== [] && value !== '') {
    return { valid: true };
  }

  return { valid: false, errors: [':field: should not be empty'] };
};
