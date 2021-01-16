#!/usr/bin/ruby

require 'sinatra'
require_relative 'task-manager'
require 'lib/logger'

class TaskServiceRESTAPI < Sinatra::Base
  configure do
    set :bind, '0.0.0.0'
    set :port, 50052
    set :show_exceptions, :after_handler
    set :server, :puma
  end

  post "/tasks" do
    Logger.debug "POST tasks"

    payload = JSON.parse(request.body.read)

    Logger.debug payload

    Logger.debug payload['data']
    attributes = payload['data']['attributes']
    relationships = payload['data']['relationships']

    Logger.debug attributes
    Logger.debug relationships

    inserted_task = TaskManager.create_task(relationships['owner']['data']['id'], attributes['title'], attributes['description'], attributes['due_date'])

    response = {
      :data => inserted_task,
    }
    Logger.debug response

    [ 200, response.to_json ]
  end

  patch "/tasks/:id" do |id|
    Logger.debug "PATCH tasks"

    data = JSON.parse(request.body.read)
    data.delete!(:_id)

    Logger.debug data

    response = TaskManager.update_one(id, data)

    response = {
      :data => response,
    }

    headers['Content-Type'] = 'application/vnd.api+json'
    Logger.debug response.to_json

    [ 200, response.to_json ]
  end


  delete "/tasks/:id" do |id|
    Logger.debug "DELETE tasks"
    Logger.debug id
    headers['Content-Type'] = 'application/vnd.api+json'

    response = TaskManager.delete_task(id)
    response = {
      :data => response,
    }

    [ 200, response.to_json ]
  end

  get "/tasks/:id" do |id|
    Logger.debug "GET task"
    Logger.debug id

    response = TaskManager.find_task(id)
    response = {
      :data => response,
    }

    Logger.debug response.to_json
    [ 200, response.to_json ]
  end

  get "/tasks" do
    Logger.debug "GET tasks"
    Logger.debug params

    response = TaskManager.find(params)
    response = {
      :data => response,
    }
    Logger.debug response

    [ 200, response.to_json ]
  end
end

