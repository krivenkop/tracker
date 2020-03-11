export default (password, anotherPassword) => {
  if (password === anotherPassword) {
    return { valid: true };
  }

  return { valid: false, errors: [':field: is not matching password'] };
};
