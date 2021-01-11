import RESTSerializer from '@ember-data/serializer/rest';
import { underscore } from '@ember/string';

export default class TaskSerializer extends RESTSerializer {
  primaryKey = '_id';

  keyForAttribute(attr) {
    return underscore(attr);
  }

  normalizeResponse(store, primaryModelClass, payload, id, requestType) {
    console.log(payload);

    if(!Array.isArray(payload))
      payload = [payload]

    payload = {
      tasks: payload
    }

    return super.normalizeResponse(store, primaryModelClass, payload, id, requestType);
  }


}
