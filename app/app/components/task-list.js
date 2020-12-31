import Component from '@glimmer/component';
import { action } from '@ember/object';

export default class TaskListComponent extends Component{
  @action
  createTask() {
    console.log(this.store);
    this.args.createTask();
  }
};
