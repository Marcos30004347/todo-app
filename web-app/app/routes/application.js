import Route from '@ember/routing/route';

export default class ApplicationRoute extends Route {
  model() {
    this.store.push({
        data: [{
          id: 1,
          type: 'user',
          attributes: {
            username: "Seratos",
            tasks: []
          },
          relationships: {
            tasks: {
              data: [
                { id: 1, type: "task" },
              ]
            }
          }
        },
        {
          id: 1,
          type: 'task',
          attributes: {
            title: "Teste",
            description: "Testando...",
            due: new Date(),
          },
          relationships: {
            owner: {
              data: {
                id: 1,
                type: "user",
              }
            }
          }
        }
      ]
    });

    return {
      tasks: this.store.peekAll("task"),
    }
  }

  setupController(controller, model) {
    super.setupController(controller, model);
    this.controllerFor('application').set('tasks', this.store.peekAll("task"));
  }
}
