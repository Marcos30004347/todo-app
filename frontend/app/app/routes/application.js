import Route from '@ember/routing/route';

export default class ApplicationRoute extends Route {
  model() {
    // this.store.push({
    //     data: [{
    //       id: 1,
    //       type: 'user',
    //       attributes: {
    //         username: "Seratos",
    //         tasks: []
    //       },
    //       relationships: {
    //         tasks: {
    //           data: [
    //             { id: 1, type: "task" },
    //           ]
    //         }
    //       }
    //     },
    //     {
    //       id: 1,
    //       type: 'task',
    //       attributes: {
    //         title: "Teste",
    //         description: "Testando...",
    //         due: new Date(),
    //       },
    //       relationships: {
    //         owner: {
    //           data: {
    //             id: 1,
    //             type: "user",
    //           }
    //         }
    //       }
    //     }
    //   ]
    // });

    // return {
    //   tasks: this.store.peekAll("task"),
    // }
    // console.log("ASDASDSAA");
    // fetch('http://task-api/task/5ff8c52e73681500075db023');
    // console.log("ASDASDSAA");

    // this.store.findRecord("task", "5ff8c52e73681500075db023");
    // let teste = this.store.createRecord("task", {
    //   title: "Teste",
    //   description: "Description",
    //   dueDate: new Date(),
    //   user: "asdasda",
    // });
    // teste.save();
    // this.store.findRecord("task", "5fee3fc21a3837000ad7d558").then(function(task) {
    //   // ...after the record has loaded
    //   task.title = 'A new task';
    //   task.save();
    // });

    // console.log("teste")
    // console.log(teste)
    // console.log("teste");
    // return this.store.query("task", {
    //   user: 1,
    // })
    return this.store.findAll("task");
  }

  setupController(controller, model) {
    super.setupController(controller, model);
    console.log(model);3
    this.controllerFor('application').set('tasks', model);
  }
}
