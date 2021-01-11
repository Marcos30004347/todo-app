import JSONAPISerializer from '@ember-data/serializer/json-api';
import { underscore } from '@ember/string';

export default class TaskSerializer extends JSONAPISerializer {
  // primaryKey = 'id';

  keyForAttribute(attr) {
    return underscore(attr);
  }
  attrs = {
    owner: { serialize: true }
  }

  serialize(snapshot, options) {
    return super.serialize(...arguments);
  }

  normalizeResponse(store, primaryModelClass, payload, id, requestType) {
    return super.normalizeResponse(store, primaryModelClass, payload, id, requestType);
  }

  normalizeArrayResponse(store, primaryModelClass, payload, id, requestType) {
    return super.normalizeArrayResponse(store, primaryModelClass, payload, id, requestType);
  }

  normalizeSingleResponse(store, primaryModelClass, payload, id, requestType) {
    return super.normalizeSingleResponse(store, primaryModelClass, payload, id, requestType);
  }
}
