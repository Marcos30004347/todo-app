import JSONAPIAdapter from '@ember-data/adapter/json-api';

export default class TaskAdapter extends JSONAPIAdapter {
  host = 'http://localhost:1000/task-api.com';
  // host = 'http://todo-api/task-api.com';
  // host = 'http://todo-api:1000/task-api.com';

  // get headers() {
  //   return {
  //     'API_KEY': get(document.cookie.match(/apiKey\=([^;]*)/), '1'),
  //     'ANOTHER_HEADER': 'Some header value'
  //   };
  // }

  pathForType() {
    return 'task-api';
  }
}
