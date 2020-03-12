export default (length) => {
  // eslint-disable-next-line no-bitwise
  return [...Array(length)].map(() => (~~(Math.random() * 36)).toString(36)).join('');
};
