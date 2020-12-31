#!/usr/bin/ruby

require 'todo-mongo'
require 'todo-logger'

class TaskManager
    def initialize
        @@mongo_client = ToDo::MongoDB::Client.new('taskdb:27017', 'tasks')
        @@task_collection = @@mongo_client.collection "tasks"
    end

    def self.create_task(user, title, description, due_date)
        @@task_collection.insert_one({
            'user'          => user,
            'title'         => title,
            'state'         => 0,
            'description'   => description,
            'due_date'      => due_date
        })
    end

    def self.update_task_title(id, new_title)
        @@task_collection.update_one(
            { '_id' => id },
            { '$set' => { 'title' => new_title } }
        )
    end

    def self.update_task_state(id, new_state)
        @@task_collection.update_one(
            { '_id' => id },
            { '$set' => { 'state' => new_state } }
        )
    end

    def self.update_task_description(id, new_description)
        @@task_collection.update_one(
            { '_id' => id },
            { '$set' => { 'description' => new_description } }
        )
    end

    def self.update_task_due_date(id, new_due_date)
        @@task_collection.update_one(
            { '_id' => id },
            { '$set' => { 'due_date' => new_due_date } }
        )
    end

    def self.delete_task(id)
        @@task_collection.delete_one({ '_id' => id })
    end

    def self.find_task(id)
        @@task_collection.find({ '_id' => id })
    end
end