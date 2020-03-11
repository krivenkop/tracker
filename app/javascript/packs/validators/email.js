const emailRegex = /^(([^\s"(),.:;<>@[\\\]]+(\.[^\s"(),.:;<>@[\\\]]+)*)|(".+"))@((\[(?:\d{1,3}\.){3}\d{1,3}])|(([\d-A-Za-z]+\.)+[A-Za-z]{2,}))$/;

export default (value) => {
  if (emailRegex.test(String(value).toLowerCase())) {
    return { valid: true };
  }

  return { valid: false, errors: [':field: is not valid'] };
};
