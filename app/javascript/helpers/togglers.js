const showElement = (element) => element.classList.remove('hidden');
const hideElement = (element) => element.classList.add('hidden')

const hideAll = (elements) => elements.map(hideElement);
const showAll = (elements) => elements.map(showElement);

export { hideAll, showAll };
