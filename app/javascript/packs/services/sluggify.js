import randomString from './random-string';

export default (str) => {
  const slug = str.slice(0, 5).toLowerCase();

  return `${slug}_${randomString(10)}`;
};
