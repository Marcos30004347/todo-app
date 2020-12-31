#!/usr/bin/ruby

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, '../lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'mongo'
require 'grpc'
require 'helloworld_services_pb'

class GreeterServer < Helloworld::Greeter::Service
    def say_hello(hello_req, _unused_call)
        Helloworld::HelloReply.new(message: "Hello #{hello_req.name}")
    end
end

def main
    # Database
    client = Mongo::Client.new('mongodb://taskdb:27017/tasks')
    db = client.database
    db.collections # returns a list of collection objects
    task_collection = client['tasks']
    doc = {
        title: 'To do',
        description: 'To do',
    }
    result = task_collection.insert_one(doc)

    # gRPC API
    server = GRPC::RpcServer.new
    server.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
    server.handle(GreeterServer)
    server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main