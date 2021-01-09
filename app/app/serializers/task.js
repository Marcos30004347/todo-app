import JSONAPISerializer from '@ember-data/serializer/json-api';

export default class TaskSerializer extends JSONAPISerializer {
  primaryKey = '_id';
  attrs = {
    // familyName: 'familyNameOfPerson'
  };

  keyForAttribute(attr) {
    return underscore(attr);
  }

  serialize(snapshot, options) {
    let json = super.serialize(...arguments);
    json.data.due_date = new Date(json.data.due_date)
    return json;
  }
}
