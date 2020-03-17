export default () => {
  return localStorage.getItem('reduxState')
    ? JSON.parse(localStorage.getItem('reduxState')) : {};
};
