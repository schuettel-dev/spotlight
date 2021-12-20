const show = (element) => element.classList.remove('hidden');
const hide = (element) => element.classList.add('hidden')

const hideAll = (elements) => elements.map(hide);
const showAll = (elements) => elements.map(show);

export { show, hide, hideAll, showAll };
