import Model, { attr, belongsTo } from '@ember-data/model';

export default class TaskModel extends Model {
  @attr("string") title;
  @attr("string") description;
  @attr("date") due;
  @belongsTo("user") owner;
}
