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
    const task = this.store.peekRecord("task", 1);
    console.log(task.title);
    const tasks = this.store.peekAll("task");
    console.log(tasks.toArray()[0].title);
    return {
      tasks: tasks.toArray(),
    }
  }
}
