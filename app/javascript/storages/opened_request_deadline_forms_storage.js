const openedRequestDeadlineForms = () => {
  return JSON.parse(window.localStorage.getItem('openedRequestDeadlineForms') || "[]");
}

const setOpenedRequestDeadlineForms = (value) => {
  window.localStorage.setItem('openedRequestDeadlineForms', JSON.stringify(value))
}

const requestDeadlineIdIncludedInOpenedRequestDeadlineForms = (id) => {
  return openedRequestDeadlineForms().includes(id);
}

const requestDeadlineFormOpened = (id) => {
  return requestDeadlineIdIncludedInOpenedRequestDeadlineForms(id);
}

const addToOpenedRequestDeadlineForms = (id) => {
  if (!requestDeadlineIdIncludedInOpenedRequestDeadlineForms(id)) {
    const newOpenedRequestDeadlineForms = openedRequestDeadlineForms();
    newOpenedRequestDeadlineForms.push(id);
    setOpenedRequestDeadlineForms(newOpenedRequestDeadlineForms);
  }
}

const removeFromOpenedRequestDeadlineForms = (id) => {
  if (requestDeadlineIdIncludedInOpenedRequestDeadlineForms(id)) {
    const newOpenedRequestDeadlineForms = openedRequestDeadlineForms().filter((requestDeadlineId) => requestDeadlineId != id);
    setOpenedRequestDeadlineForms(newOpenedRequestDeadlineForms);
  }
}

const toggleRequestDeadlineForm = (id) => {
  if (requestDeadlineFormOpened(id)) {
    removeFromOpenedRequestDeadlineForms(id);
  } else {
    addToOpenedRequestDeadlineForms(id);
  }
  window.dispatchEvent(new CustomEvent('admin--requestDeadline-form-toggled', { detail: { requestDeadlineId: id }}));
}

export { requestDeadlineFormOpened, toggleRequestDeadlineForm };
