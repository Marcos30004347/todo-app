#!/usr/bin/ruby

require 'lib/logger'

require 'network/rest_api'
require 'network/grpc_api'

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
