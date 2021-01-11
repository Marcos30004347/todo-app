import JSONAPIAdapter from '@ember-data/adapter/json-api';
import { pluralize } from 'ember-inflector';

export default class TaskAdapter extends JSONAPIAdapter {
  host = 'http://localhost:1000/task-api';

  pathForType() {
    return 'tasks';
  }

  updateRecord(store, type, snapshot) {
    console.log("updateRecord");

    var data = {};
    var serializer = store.serializerFor(type.modelName);
    var id = snapshot.id;
    var url = this.buildURL(type.modelName, id, snapshot, 'updateRecord');
    serializer.serializeIntoHash(data, type, snapshot, { includeId: true });
    return this.ajax(url, 'PATCH', { data: data });
  }

  findRecord(store, type, id, snapshot) {
    console.log("findRecord");

    var data = {};
    var serializer = store.serializerFor(type.modelName);
    var url = this.buildURL(type.modelName, id, snapshot, 'findRecord');
    serializer.serializeIntoHash(data, type, snapshot, { includeId: true });
    return this.ajax(url, 'GET', { data: data });
  }

  createRecord(store, type, snapshot) {
    console.log("createRecord");

    var data = {};
    var serializer = store.serializerFor(type.modelName);
    var id = snapshot.id;
    var url = this.buildURL(type.modelName, id, snapshot, 'createRecord');
    serializer.serializeIntoHash(data, type, snapshot, { includeId: true });
    return this.ajax(url, 'POST', { data: data });
  }

  deleteRecord(store, type, snapshot) {
    console.log("deleteRecord");

    var data = {};
    var serializer = store.serializerFor(type.modelName);
    var id = snapshot.id;
    var url = this.buildURL(type.modelName, id, snapshot, 'deleteRecord');
    serializer.serializeIntoHash(data, type, snapshot, { includeId: true });
    return this.ajax(url, 'DELETE', { data: data });
  }

  findAll (store, type, neverSet, snapshot) {
    var url = this.urlForFindAll(type.modelName, snapshot);
    return this.ajax(url, 'GET');
  }

  findMany (store, type, ids, snapshots) {
    console.log("findMany");
    this._super(store, type, ids, snapshots);

  }

  findBelongsTo (store, snapshot, url, relationship) {
    console.log("findBelongsTo");
    this._super(store, snapshot, url, relationship);
  }

  findHasMany (store, snapshot, url, relationship) {
    console.log("findHasMany");
    this._super(store, snapshot, url, relationship);
  }

}
