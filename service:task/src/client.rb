#!/usr/bin/ruby

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'helloworld_services_pb'

def main
  hostname = ARGV.size > 1 ?  ARGV[1] : 'localhost:50051'
  stub = Helloworld::Greeter::Stub.new(hostname, :this_channel_is_insecure)
  
  message = stub.say_hello(Helloworld::HelloRequest.new(name: "Marcos")).message
  p "Greeting: #{message}"
end

main