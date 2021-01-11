#!/usr/bin/ruby

require 'sinatra'
require_relative 'task-manager'
require 'todo-logger'

class TaskServiceRESTAPI < Sinatra::Base
    configure do
        set :bind, '0.0.0.0'
        set :port, 50052
        set :show_exceptions, :after_handler
        set :server, :puma
    end 

    post "/tasks" do
        ToDo::Logger.debug "POST tasks"
        
        payload = JSON.parse(request.body.read)
    
        ToDo::Logger.debug payload
        
        ToDo::Logger.debug payload['data']
        attributes = payload['data']['attributes']
        relationships = payload['data']['relationships']
    
        ToDo::Logger.debug attributes
        ToDo::Logger.debug relationships

        inserted_task = TaskManager.create_task(relationships['owner']['data']['id'], attributes['title'], attributes['description'], attributes['due_date'])
        
        response = {
            :data => inserted_task,
        }
        ToDo::Logger.debug response

        [ 200, response.to_json ]
    end

    patch "/tasks/:id" do |id|
        ToDo::Logger.debug "PATCH tasks"

        data = JSON.parse(request.body.read)
        data.delete!(:_id)

        ToDo::Logger.debug data

        response = TaskManager.update_one(id, data)

        response = {
            :data => response,
        }

        headers['Content-Type'] = 'application/vnd.api+json'
        ToDo::Logger.debug response.to_json
    
        [ 200, response.to_json ]
    end


    delete "/tasks/:id" do |id|
        ToDo::Logger.debug "DELETE tasks"
        ToDo::Logger.debug id
        headers['Content-Type'] = 'application/vnd.api+json'

        response = TaskManager.delete_task(id)
        response = {
            :data => response,
        }

        [ 200, response.to_json ]
    end

    get "/tasks/:id" do |id|
        ToDo::Logger.debug "GET task"
        ToDo::Logger.debug id

        response = TaskManager.find_task(id)
        response = {
            :data => response,
        }

        ToDo::Logger.debug response.to_json
        [ 200, response.to_json ]
    end

    get "/tasks" do
        ToDo::Logger.debug "GET tasks"
        ToDo::Logger.debug params
        
        response = TaskManager.find(params)
        response = {
            :data => response,
        }
        ToDo::Logger.debug response

        [ 200, response.to_json ]
    end
end

