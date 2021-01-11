import JSONAPISerializer from '@ember-data/serializer/json-api';

export default class UserSerializer extends JSONAPISerializer {
  keyForAttribute(attr) {
    return underscore(attr);
  }
  // serialize(snapshot, options) {
  //   console.log("asdasdsda");
  //   let json = super.serialize(...arguments);
  // }
}
