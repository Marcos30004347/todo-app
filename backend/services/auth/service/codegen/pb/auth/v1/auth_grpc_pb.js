// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('grpc');
var auth_v1_auth_pb = require('../../auth/v1/auth_pb.js');

function serialize_auth_HelloReply(arg) {
  if (!(arg instanceof auth_v1_auth_pb.HelloReply)) {
    throw new Error('Expected argument of type auth.HelloReply');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_auth_HelloReply(buffer_arg) {
  return auth_v1_auth_pb.HelloReply.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_auth_HelloRequest(arg) {
  if (!(arg instanceof auth_v1_auth_pb.HelloRequest)) {
    throw new Error('Expected argument of type auth.HelloRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_auth_HelloRequest(buffer_arg) {
  return auth_v1_auth_pb.HelloRequest.deserializeBinary(new Uint8Array(buffer_arg));
}


// The greeting service definition.
var AuthService = exports.AuthService = {
  // Sends a greeting
sayHello: {
    path: '/auth.Auth/SayHello',
    requestStream: false,
    responseStream: false,
    requestType: auth_v1_auth_pb.HelloRequest,
    responseType: auth_v1_auth_pb.HelloReply,
    requestSerialize: serialize_auth_HelloRequest,
    requestDeserialize: deserialize_auth_HelloRequest,
    responseSerialize: serialize_auth_HelloReply,
    responseDeserialize: deserialize_auth_HelloReply,
  },
};

exports.AuthClient = grpc.makeGenericClientConstructor(AuthService);
