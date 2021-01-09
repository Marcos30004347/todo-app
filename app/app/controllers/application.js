import Controller from '@ember/controller';
import { action } from '@ember/object';

export default class ApplicationController extends Controller {
  @action
  createTask() {
    // this.store.push({
    //   data: [{
    //     id: this.tasks.toArray().length + 1,
    //     type: 'task',
    //     attributes: {
    //       title: "Teste",
    //       description: "Testando...",
    //       due: new Date(),
    //     },
    //     relationships: {
    //       owner: {
    //         data: {
    //           id: 1,
    //           type: "user",
    //         }
    //       }
    //     }
    //   }]
    // });
  }
}
