import Component from '@glimmer/component';
import { action } from '@ember/object';

// import { tracked } from '@glimmer/tracking';
// import { action } from '@ember/object';

export default class TaskComponent extends Component{
  @action
  teste() {
    console.log(this);
  }

  log(message) {
    console.log(message);
  }
};
