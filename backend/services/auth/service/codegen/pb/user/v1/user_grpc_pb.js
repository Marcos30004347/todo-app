// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('grpc');
var user_v1_user_pb = require('../../user/v1/user_pb.js');

function serialize_user_HelloReply(arg) {
  if (!(arg instanceof user_v1_user_pb.HelloReply)) {
    throw new Error('Expected argument of type user.HelloReply');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_user_HelloReply(buffer_arg) {
  return user_v1_user_pb.HelloReply.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_user_HelloRequest(arg) {
  if (!(arg instanceof user_v1_user_pb.HelloRequest)) {
    throw new Error('Expected argument of type user.HelloRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_user_HelloRequest(buffer_arg) {
  return user_v1_user_pb.HelloRequest.deserializeBinary(new Uint8Array(buffer_arg));
}


// The greeting service definition.
var UserService = exports.UserService = {
  // Sends a greeting
sayHello: {
    path: '/user.User/SayHello',
    requestStream: false,
    responseStream: false,
    requestType: user_v1_user_pb.HelloRequest,
    responseType: user_v1_user_pb.HelloReply,
    requestSerialize: serialize_user_HelloRequest,
    requestDeserialize: deserialize_user_HelloRequest,
    responseSerialize: serialize_user_HelloReply,
    responseDeserialize: deserialize_user_HelloReply,
  },
};

exports.UserClient = grpc.makeGenericClientConstructor(UserService);
