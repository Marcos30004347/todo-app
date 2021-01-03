import { HelloReply } from '../lib/typescript/helloworld_pb';
import { GreeterService } from '../lib/typescript/helloworld_grpc_pb';
import { ServerUnaryCall, sendUnaryData, Server, ServerCredentials } from 'grpc'

function sayHello(call: ServerUnaryCall<any>, callback: sendUnaryData<HelloReply>): void {
  var reply = new HelloReply();
  reply.setMessage('Hello ' + call.request.getName());
  callback(null, reply);
}

function main() {
  var server = new Server();
  server.addService(GreeterService, { sayHello: sayHello });
  server.bind('0.0.0.0:50051', ServerCredentials.createInsecure());
  server.start();
}

main();