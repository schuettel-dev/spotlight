const openedUserForms = () => {
  return JSON.parse(window.localStorage.getItem('openedUserForms') || "[]");
}

const setOpenedUserForms = (value) => {
  window.localStorage.setItem('openedUserForms', JSON.stringify(value))
}

const userIdIncludedInOpenedUserForms = (id) => {
  return openedUserForms().includes(id);
}

const userFormOpened = (id) => {
  return userIdIncludedInOpenedUserForms(id);
}

const addToOpenedUserForms = (id) => {
  if (!userIdIncludedInOpenedUserForms(id)) {
    const newOpenedUserForms = openedUserForms();
    newOpenedUserForms.push(id);
    setOpenedUserForms(newOpenedUserForms);
  }
}

const removeFromOpenedUserForms = (id) => {
  if (userIdIncludedInOpenedUserForms(id)) {
    const newOpenedUserForms = openedUserForms().filter((userId) => userId != id);
    setOpenedUserForms(newOpenedUserForms);
  }
}

const toggleUserForm = (id) => {
  if (userFormOpened(id)) {
    removeFromOpenedUserForms(id);
  } else {
    addToOpenedUserForms(id);
  }
  window.dispatchEvent(new CustomEvent('user-form-toggled', { detail: { userId: id }}));
}

export { userFormOpened, toggleUserForm };
