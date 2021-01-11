import Route from '@ember/routing/route';

export default class ApplicationRoute extends Route {
  async model() {
    // this.store.push({
    //   data: [
    //     {
    //       id: "1234",
    //       type: 'user',
    //       attributes: {
    //         username: "Marcos"
    //       }
    //     }
    //   ]
    // });

    // let user = this.store.peekRecord("user", "1234");

    // let task = this.store.createRecord("task", {
    //   title: "To do!",
    //   description: "blahblablah...",
    //   dueDate: new Date(),
    //   owner: user,
    // });

    // user.get("tasks").pushObject(task);

    return this.store.query("task", {
      "attributes.title": "To do!",
    });
  }

  setupController(controller, model) {
    super.setupController(controller, model);
    this.controllerFor('application').set('tasks', model);
  }
}
