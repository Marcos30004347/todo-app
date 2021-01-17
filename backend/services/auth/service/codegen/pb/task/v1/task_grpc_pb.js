// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('grpc');
var task_v1_task_pb = require('../../task/v1/task_pb.js');

function serialize_task_HelloReply(arg) {
  if (!(arg instanceof task_v1_task_pb.HelloReply)) {
    throw new Error('Expected argument of type task.HelloReply');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_task_HelloReply(buffer_arg) {
  return task_v1_task_pb.HelloReply.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_task_HelloRequest(arg) {
  if (!(arg instanceof task_v1_task_pb.HelloRequest)) {
    throw new Error('Expected argument of type task.HelloRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_task_HelloRequest(buffer_arg) {
  return task_v1_task_pb.HelloRequest.deserializeBinary(new Uint8Array(buffer_arg));
}


// The greeting service definition.
var TaskService = exports.TaskService = {
  // Sends a greeting
sayHello: {
    path: '/task.Task/SayHello',
    requestStream: false,
    responseStream: false,
    requestType: task_v1_task_pb.HelloRequest,
    responseType: task_v1_task_pb.HelloReply,
    requestSerialize: serialize_task_HelloRequest,
    requestDeserialize: deserialize_task_HelloRequest,
    responseSerialize: serialize_task_HelloReply,
    responseDeserialize: deserialize_task_HelloReply,
  },
};

exports.TaskClient = grpc.makeGenericClientConstructor(TaskService);
