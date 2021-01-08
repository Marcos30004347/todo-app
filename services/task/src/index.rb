#!/usr/bin/ruby

require_relative 'rest_api'
require_relative 'grpc_api'


class TaskService
    def self.setup
        TaskManager.setup
        ToDo::Logger.new
    end

    def self.run!
        TaskServiceRESTAPI.run!
        TaskServiceGRPCAPI.run!
    end
end

TaskService.setup
TaskService.run!