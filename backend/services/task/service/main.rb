#!/usr/bin/ruby

require_relative 'lib/logger'

require_relative 'rest_api'
require_relative 'grpc_api'

class TaskService
  def self.setup
    TaskManager.setup
    Logger.new
  end

  def self.run!
    TaskServiceRESTAPI.run!
    TaskServiceGRPCAPI.run!
  end
end

TaskService.setup
TaskService.run!
