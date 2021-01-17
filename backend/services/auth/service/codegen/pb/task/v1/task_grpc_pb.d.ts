// package: task
// file: task/v1/task.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "grpc";
import * as task_v1_task_pb from "../../task/v1/task_pb";

interface ITaskService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    sayHello: ITaskService_ISayHello;
}

interface ITaskService_ISayHello extends grpc.MethodDefinition<task_v1_task_pb.HelloRequest, task_v1_task_pb.HelloReply> {
    path: "/task.Task/SayHello";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<task_v1_task_pb.HelloRequest>;
    requestDeserialize: grpc.deserialize<task_v1_task_pb.HelloRequest>;
    responseSerialize: grpc.serialize<task_v1_task_pb.HelloReply>;
    responseDeserialize: grpc.deserialize<task_v1_task_pb.HelloReply>;
}

export const TaskService: ITaskService;

export interface ITaskServer {
    sayHello: grpc.handleUnaryCall<task_v1_task_pb.HelloRequest, task_v1_task_pb.HelloReply>;
}

export interface ITaskClient {
    sayHello(request: task_v1_task_pb.HelloRequest, callback: (error: grpc.ServiceError | null, response: task_v1_task_pb.HelloReply) => void): grpc.ClientUnaryCall;
    sayHello(request: task_v1_task_pb.HelloRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: task_v1_task_pb.HelloReply) => void): grpc.ClientUnaryCall;
    sayHello(request: task_v1_task_pb.HelloRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: task_v1_task_pb.HelloReply) => void): grpc.ClientUnaryCall;
}

export class TaskClient extends grpc.Client implements ITaskClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: object);
    public sayHello(request: task_v1_task_pb.HelloRequest, callback: (error: grpc.ServiceError | null, response: task_v1_task_pb.HelloReply) => void): grpc.ClientUnaryCall;
    public sayHello(request: task_v1_task_pb.HelloRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: task_v1_task_pb.HelloReply) => void): grpc.ClientUnaryCall;
    public sayHello(request: task_v1_task_pb.HelloRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: task_v1_task_pb.HelloReply) => void): grpc.ClientUnaryCall;
}
