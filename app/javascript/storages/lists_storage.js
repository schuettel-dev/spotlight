class ListsStorage {
  constructor(key) {
    this.key = key;
  }

  get storage() {
    return window.localStorage;
  }

  get list() {
    return new Set(JSON.parse(this.storage.getItem(this.key) || "[]"));
  }

  write(newSet) {
    this.storage.setItem(this.key, JSON.stringify([...newSet]));
  }

  add(value) {
    this.write(this.list.add(value));
  }

  delete(value) {
    const newList = this.list;
    newList.delete(value);
    this.write(newList);
  }

  has(value) {
    return this.list.has(value);
  }

  toggle(value) {
    if (this.has(value)) {
      this.delete(value);
    } else {
      this.add(value);
    }
  }
}

const listsStorage = (key) => {
  return new ListsStorage(key);
}

export { listsStorage };
