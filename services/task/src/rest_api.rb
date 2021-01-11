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
    post "/tasks" do
        data = JSON.parse(request.body.read)
        
        id = TaskManager.create_task(data['task']['user'], data['task']['title'], data['task']['description'], data['task']['due_date'])
        
        object = {
            '_id' => id.to_s,
            'user' => data['task']['user'],
            'title' => data['task']['title'],
            'description' => data['task']['description'],
            'due_date' => data['task']['due_date'],
        }
        
        [ 200, object.to_json ]
    end

    patch "/tasks/:id" do |id|
        data = JSON.parse(request.body.read)
        data.delete!(:_id)
        response = TaskManager.update_one(id, data)
        [200, response.to_json]
    end


    delete "/tasks/:id" do |id|
        response = TaskManager.delete_task(id)
        [200, response.to_json]
    end

    get "/tasks/:id" do |id|
        ToDo::Logger.debug id
        response = TaskManager.find_task(id)
        ToDo::Logger.debug response.to_json
        [200, response.to_json]
    end

    get "/tasks" do
        if params[:user] != nil 
            params[:user] = params[:user].to_i
        end
        ToDo::Logger.debug params
        response = TaskManager.find(params)
        ToDo::Logger.debug response.to_a()
        [200, response.to_a().to_json]
    end
end

