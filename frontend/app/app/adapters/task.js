import JSONAPIAdapter from '@ember-data/adapter/json-api';

export default class TaskAdapter extends JSONAPIAdapter {
  host = 'http://localhost:1000/task-api';

  pathForType() {
    return 'tasks';
  }

  updateRecord(store, type, snapshot) {
    let data = {};
    let serializer = store.serializerFor(type.modelName);
    let id = snapshot.id;
    let url = this.urlForUpdateRecord(id, type.modelName, snapshot);
    serializer.serializeIntoHash(data, type, snapshot, { includeId: true });
    return this.ajax(url, 'PATCH', { data: data });
  }

  findRecord(store, type, id, snapshot) {
    let data = {};
    let serializer = store.serializerFor(type.modelName);
    let url = this.urlForFindRecord(id, type.modelName, snapshot);
    serializer.serializeIntoHash(data, type, snapshot, { includeId: true });
    return this.ajax(url, 'GET', { data: data });
  }

  findAll (store, type, neverSet, snapshot) {
    var url = this.urlForFindAll(type.modelName, snapshot);
    return this.ajax(url, 'GET');
  }

  findMany (store, type, ids, snapshots) {
    var url = this.urlForFindMany(ids, type.modelName, snapshot);
    return this.ajax(url, 'GET');
  }

  createRecord(store, type, snapshot) {
    let data = {};
    let serializer = store.serializerFor(type.modelName);
    let id = snapshot.id;
    let url = this.urlForCreateRecord(type.modelName, id, snapshot);

    serializer.serializeIntoHash(data, type, snapshot, { includeId: true });

    return this.ajax(url, 'POST', { data: data });
  }

  deleteRecord(store, type, snapshot) {
    var data = {};
    var serializer = store.serializerFor(type.modelName);
    var id = snapshot.id;
    var url = this.urlForDeleteRecord(id, type.modelName, snapshot);
    serializer.serializeIntoHash(data, type, snapshot, { includeId: true });
    return this.ajax(url, 'DELETE', { data: data });
  }


  findBelongsTo (store, snapshot, url, relationship) {
    console.log("findBelongsTo");
    super.findBelongsTo(store, snapshot, url, relationship);
  }

  findHasMany (store, snapshot, url, relationship) {
    console.log("findHasMany");
    super.findHasMany(store, snapshot, url, relationship);
  }

}
