#!/usr/bin/ruby

require 'date'
require 'todo-mongo'
require 'todo-logger'


def date_valid?(date)
    DateTime.strptime(date, '%Y-%m-%dT%H:%M:%S.%L%z')
    true
  rescue ArgumentError
    false
end


class InvalidDateException < StandardError
    def initialize(message="Invalid Date format, date need to be in the ISO-8601 format!", exception_type="invalid_date")
      @exception_type = exception_type
      super(message)
    end
end

module BSON
    class ObjectId
      def to_json(*args)
        to_s.to_json
      end
  
      def as_json(*args)
        to_s.as_json
      end
    end
end

class String
    def to_bson_id
      BSON::ObjectId.from_string(self)
    end
end
  
class NilClass
def to_bson_id
    self
end
end

class TaskManager
    def self.setup
        @@mongo_client = ToDo::MongoDB::Client.new('taskdb:27017', 'tasks')
        @@task_collection = @@mongo_client.collection "tasks"
        @@is_connected = true
    end

    def self.is_connected? 
        @@is_connected
    end

    def self.create_task(user, title, description, due_date)
        #Verify date format
        if not date_valid?(due_date)
            raise InvalidDateException.new
        end
    
        @@task_collection.insert_one({
            'user'          => user,
            'title'         => title,
            'state'         => 0,
            'description'   => description,
            'due_date'      => due_date
        }).inserted_id
    end

    def self.update_task_title(id, new_title)
        @@task_collection.update_one(
            { '_id' => id.to_bson_id },
            { '$set' => { 'title' => new_title } }
        )
    end

    def self.update_task_state(id, new_state)
        @@task_collection.update_one(
            { '_id' => id.to_bson_id },
            { '$set' => { 'state' => new_state } }
        )
    end

    def self.update_task_description(id, new_description)
        @@task_collection.update_one(
            { '_id' => id.to_bson_id },
            { '$set' => { 'description' => new_description } }
        )
    end

    def self.update_task_due_date(id, new_due_date)
        #Verify date format
        if not date_valid?(new_due_date)
            raise InvalidDateException.new
        end
    
        @@task_collection.update_one(
            { '_id' => id.to_bson_id },
            { '$set' => { 'due_date' => new_due_date } }
        )
    end

    def self.delete_task(id)
        @@task_collection.delete_one({ '_id' => id.to_bson_id })
    end

    def self.find_task(id)
        @@task_collection.find({ '_id' => id.to_bson_id }).first
    end

    def self.find_user_tasks(user)
        @@task_collection.find({ 'user' => user })
    end
end