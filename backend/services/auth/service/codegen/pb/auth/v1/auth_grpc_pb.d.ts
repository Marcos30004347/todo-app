// package: auth
// file: auth/v1/auth.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "grpc";
import * as auth_v1_auth_pb from "../../auth/v1/auth_pb";

interface IAuthService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    sayHello: IAuthService_ISayHello;
}

interface IAuthService_ISayHello extends grpc.MethodDefinition<auth_v1_auth_pb.HelloRequest, auth_v1_auth_pb.HelloReply> {
    path: "/auth.Auth/SayHello";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<auth_v1_auth_pb.HelloRequest>;
    requestDeserialize: grpc.deserialize<auth_v1_auth_pb.HelloRequest>;
    responseSerialize: grpc.serialize<auth_v1_auth_pb.HelloReply>;
    responseDeserialize: grpc.deserialize<auth_v1_auth_pb.HelloReply>;
}

export const AuthService: IAuthService;

export interface IAuthServer {
    sayHello: grpc.handleUnaryCall<auth_v1_auth_pb.HelloRequest, auth_v1_auth_pb.HelloReply>;
}

export interface IAuthClient {
    sayHello(request: auth_v1_auth_pb.HelloRequest, callback: (error: grpc.ServiceError | null, response: auth_v1_auth_pb.HelloReply) => void): grpc.ClientUnaryCall;
    sayHello(request: auth_v1_auth_pb.HelloRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: auth_v1_auth_pb.HelloReply) => void): grpc.ClientUnaryCall;
    sayHello(request: auth_v1_auth_pb.HelloRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: auth_v1_auth_pb.HelloReply) => void): grpc.ClientUnaryCall;
}

export class AuthClient extends grpc.Client implements IAuthClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: object);
    public sayHello(request: auth_v1_auth_pb.HelloRequest, callback: (error: grpc.ServiceError | null, response: auth_v1_auth_pb.HelloReply) => void): grpc.ClientUnaryCall;
    public sayHello(request: auth_v1_auth_pb.HelloRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: auth_v1_auth_pb.HelloReply) => void): grpc.ClientUnaryCall;
    public sayHello(request: auth_v1_auth_pb.HelloRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: auth_v1_auth_pb.HelloReply) => void): grpc.ClientUnaryCall;
}
