#!/usr/bin/ruby

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, '../lib')

$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)
$LOAD_PATH.unshift this_dir unless $LOAD_PATH.include?(this_dir)

require 'grpc'
require 'helloworld_services_pb'

require 'todo-mongo'
require 'todo-logger'

require 'task-manager'

class GreeterServer < Helloworld::Greeter::Service
    def say_hello(hello_req, _unused_call)
        Helloworld::HelloReply.new(message: "Hello #{hello_req.name}")
    end
end

def main
    # Database
    ToDo::Logger.new
    TaskManager.new

    ToDo::Logger.puts "Hello"
    ToDo::Logger.debug "Hello"
    ToDo::Logger.warn "Hello"
    ToDo::Logger.error "Hello"
    
    teste = TaskManager.create_task(1, "Teste", "To do", Time.now.utc.iso8601)
    ToDo::Logger.debug teste
    ToDo::Logger.debug teste.inserted_id
    
    ToDo::Logger.debug  TaskManager.find_task(teste.inserted_id).count
    result = TaskManager.find_task(teste.inserted_id).each do |document|
        ToDo::Logger.debug document[:title]
    end

    # TaskManager.find_task(teste.inserted_id)

    # client = Mongo::Client.new('mongodb://taskdb:27017/tasks')
    # db = client.database
    # db.collections # returns a list of collection objects
    # task_collection = client['tasks']
    # doc = {
    #     title: 'To do',
    #     description: 'To do',
    # }
    # result = task_collection.insert_one(doc)

    # gRPC API
    server = GRPC::RpcServer.new
    server.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
    server.handle(GreeterServer)
    server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main