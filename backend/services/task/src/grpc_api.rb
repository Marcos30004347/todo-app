#!/usr/bin/ruby

require 'todo-mongo'
require 'todo-logger'
require 'todo-grpc'

require 'helloworld_services_pb'


class GreeterServer < Helloworld::Greeter::Service
    def say_hello(hello_req, _unused_call)
        Helloworld::HelloReply.new(message: "Hello #{hello_req.name}")
    end
end

class TaskServiceGRPCAPI
    def run! 
        this_dir = File.expand_path(File.dirname(__FILE__))
        certs_dir = File.join(this_dir, '../certs')

        files = ['ca.crt', 'server.key', 'server.crt']
        certs = files.map { |f| File.open(File.join(certs_dir, f)).read }

        server = GRPCServer.new(GreeterServer, '0.0.0.0:50051', certs)
        server.run
    end
end
