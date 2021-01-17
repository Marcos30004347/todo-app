#!/usr/bin/ruby

require 'lib/logger'
require 'codegen/pb/task/v1/task_services_pb'

require_relative 'grpc'

class TaskServer < Task::Task::Service
    def say_hello(hello_req, _unused_call)
      Task::HelloReply.new(message: "Hello #{hello_req.name}")
    end
end

class TaskServiceGRPCAPI
    def run!
        # this_dir = File.expand_path(File.dirname(__FILE__))
        # certs_dir = File.join(this_dir, '../certs')

        # files = ['ca.crt', 'server.key', 'server.crt']
        # certs = files.map { |f| File.open(File.join(certs_dir, f)).read }

        server = GRPCServer.new(AuthServer, '0.0.0.0:50052')
        server.run
    end
end
