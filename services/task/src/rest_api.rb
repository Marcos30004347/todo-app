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

    # before do
    #     if request.body.size > 0
    #         request.body.rewind
            
    #         ToDo::Logger.debug request.body.read
    #         ToDo::Logger.debug "BADASDASDASDASDASD"
    #         # ToDo::Logger.debug (JSON.parse(request.body.read))
    
    #         @request_payload = request.body.read
    #     end
    # end
      

    get '/' do
        "Hello, This is the Task service REST API. Enjoy!"
    end
    

    # curl --header "Content-Type: application/json"  --request POST --data '{"user":"1234","title":"ToDo","description":"blablabla...","due_date":"2017-01-17T12:31:26.695+11:00"}' http://localhost/task-api/task
    post "/task" do
        # begin
            data = JSON.parse(request.body.read)
            id = TaskManager.create_task(data['user'], data['title'], data['description'], data['due_date'])
            [200, id.to_s]
        # rescue
        #     [400, "Error on creating task"]
        # end
    end

    patch "/task/:id/title/:title" do |id, title|
        # begin
            response = TaskManager.update_task_title(id, title)
            [200, response.to_json]
        # rescue
        #     [400, "Error on creating task"]
        # end
    end

    patch "/task/:id/description/:description" do |id, description|
        # begin
            response = TaskManager.update_task_description(id, description)
            [200, response.to_json]
        # rescue
        #     [400, "Error on creating task"]
        # end
    end

    patch "/task/:id/due_date/:due_date" do |id, due_date|
        # begin
            response = TaskManager.update_task_due_date(id, due_date)
            [200, response.to_json]
        # rescue
        #     [400, "Error on creating task"]
        # end
    end

    patch "/task/:id/state/:state" do |id, state|
        # begin
            response = TaskManager.update_task_state(id, state)
            [200, response.to_json]
        # rescue
        #     [400, "Error on creating task"]
        # end
    end

    delete "/task/:id" do |id|
        # begin
            response = TaskManager.delete_task(id)
            [200, response.to_json]
        # rescue
        #     [400, "Error on creating task"]
        # end
    end

    get "/task/:id" do |id|
        # begin
            ToDo::Logger.debug id
            response = TaskManager.find_task(id)
            ToDo::Logger.debug response.to_json
            [200, response.to_json]
        # rescue
            # [400, "Error on finding task"]
        # end
    end

    # curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X GET http://localhost/task-api/task/5ff8c52e73681500075db023
    get "/tasks/user/:id" do |id|
        # begin
            ToDo::Logger.debug id
            response = TaskManager.find_task(id)
            ToDo::Logger.debug response.to_json
            [200, response.to_json]
        # rescue
        #     [400, "Error on creating task"]
        # end
    end
end

