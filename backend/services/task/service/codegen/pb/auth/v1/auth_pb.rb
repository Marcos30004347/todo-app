# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: auth/v1/auth.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("auth/v1/auth.proto", :syntax => :proto3) do
    add_message "auth.HelloRequest" do
      optional :name, :string, 1
    end
    add_message "auth.HelloReply" do
      optional :message, :string, 1
    end
  end
end

module Auth
  HelloRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth.HelloRequest").msgclass
  HelloReply = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth.HelloReply").msgclass
end