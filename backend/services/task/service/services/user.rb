#!/usr/bin/ruby

# this_dir = File.expand_path(File.dirname(__FILE__))
# lib_dir = File.join(this_dir, '../lib/ruby/lib')

# $LOAD_PATH.unshift lib_dir  unless $LOAD_PATH.include?(lib_dir)
# $LOAD_PATH.unshift this_dir unless $LOAD_PATH.include?(this_dir)

require 'grpc'
require 'codegen/pb/user/v1/user_services_pb'

require_relative 'lib/grpc'

def main
  # this_dir = File.expand_path(File.dirname(__FILE__))
  # certs_dir = File.join(this_dir, '../certs')

  # files = ['ca.crt', 'client.key', 'client.crt']
  # certs = files.map { |f| File.open(File.join(certs_dir, f)).read }

  connection = GRPCConnection.new('localhost:50051')
  client = connection.client
end

main
