// package: user
// file: user/v1/user.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "grpc";
import * as user_v1_user_pb from "../../user/v1/user_pb";

interface IUserService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    sayHello: IUserService_ISayHello;
}

interface IUserService_ISayHello extends grpc.MethodDefinition<user_v1_user_pb.HelloRequest, user_v1_user_pb.HelloReply> {
    path: "/user.User/SayHello";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<user_v1_user_pb.HelloRequest>;
    requestDeserialize: grpc.deserialize<user_v1_user_pb.HelloRequest>;
    responseSerialize: grpc.serialize<user_v1_user_pb.HelloReply>;
    responseDeserialize: grpc.deserialize<user_v1_user_pb.HelloReply>;
}

export const UserService: IUserService;

export interface IUserServer {
    sayHello: grpc.handleUnaryCall<user_v1_user_pb.HelloRequest, user_v1_user_pb.HelloReply>;
}

export interface IUserClient {
    sayHello(request: user_v1_user_pb.HelloRequest, callback: (error: grpc.ServiceError | null, response: user_v1_user_pb.HelloReply) => void): grpc.ClientUnaryCall;
    sayHello(request: user_v1_user_pb.HelloRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: user_v1_user_pb.HelloReply) => void): grpc.ClientUnaryCall;
    sayHello(request: user_v1_user_pb.HelloRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: user_v1_user_pb.HelloReply) => void): grpc.ClientUnaryCall;
}

export class UserClient extends grpc.Client implements IUserClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: object);
    public sayHello(request: user_v1_user_pb.HelloRequest, callback: (error: grpc.ServiceError | null, response: user_v1_user_pb.HelloReply) => void): grpc.ClientUnaryCall;
    public sayHello(request: user_v1_user_pb.HelloRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: user_v1_user_pb.HelloReply) => void): grpc.ClientUnaryCall;
    public sayHello(request: user_v1_user_pb.HelloRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: user_v1_user_pb.HelloReply) => void): grpc.ClientUnaryCall;
}
