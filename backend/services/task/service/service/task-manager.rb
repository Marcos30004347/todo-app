#!/usr/bin/ruby

require 'date'

require 'database/mongo'
require 'lib/logger'


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
        @@mongo_client = MongoDB::Client.new('taskdb:27017', 'tasks')
        @@task_collection = @@mongo_client.collection "tasks"
        @@is_connected = true
    end

    def self.is_connected?
        @@is_connected
    end

    def self.create_task(user, title, description, due_date)
        if not date_valid?(due_date)
            raise InvalidDateException.new
        end

        object = {
            :attributes => {
                :title         => title,
                :description   => description,
                :due_date      => due_date
            },
            :relationships => {
                :owner => {
                    :data => {
                        :type => 'users',
                        :id => user
                    }
                },
            },
        }

        ToDo::Logger.debug object

        object[:id] = @@task_collection.insert_one(object).inserted_id.to_s
        object[:type] = 'tasks'

        ToDo::Logger.debug object
        object
    end

    def self.update_one(id, values)
        @@task_collection.update_one(
            { '_id' => id.to_bson_id },
            { '$set' => { 'atributes' => values } }
        )
        self.find_task(id);
    end

    def self.delete_task(id)
        deleted_task = self.find_task(id);
        @@task_collection.delete_one({ '_id' => id.to_bson_id })
        deleted_task
    end

    def self.find_task(id)
        @@task_collection.aggregate([
            { '$match' => { '_id' => id.to_bson_id } },
            { '$addFields' => { 'id' => '$_id', 'type' => 'task' } },
            { '$unset' => ['_id'] }
        ]).first
    end

    def self.find(query)
        @@task_collection.aggregate([
            { '$match' => query },
            { '$addFields' => { 'id' => '$_id', 'type' => 'task' } },
            { '$unset' => ['_id'] }
        ]).to_a
    end
end
