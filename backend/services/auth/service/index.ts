import { HelloReply, HelloRequest } from "../codegen/pb/helloworld_pb"
import { GreeterService, IGreeterServer } from '../codegen/pb/helloworld_grpc_pb';
import { ServerUnaryCall, sendUnaryData, Server, ServerCredentials } from 'grpc'

// import fs from "fs";
// import path from "path";


class Handler implements IGreeterServer {
    public sayHello(call: ServerUnaryCall<HelloRequest>, callback: sendUnaryData<HelloReply>) : void {
      var reply = new HelloReply();
      reply.setMessage('Hello ' + call.request.getName());
      callback(null, reply);
    }
}

function main() {
  var server = new Server();
  server.addService(GreeterService, new Handler());

  server.bind('0.0.0.0:8080',
    ServerCredentials.createInsecure()
  //  ServerCredentials.createSsl(
  //       fs.readFileSync(path.join(process.cwd(), "certs", "ca.crt")),
  //       [{
  //           private_key: fs.readFileSync(path.join(process.cwd(), "certs", "server.key")),
  //           cert_chain: fs.readFileSync(path.join(process.cwd(), "certs", "server.crt")),
  //       }],
  //       true
  //   )
    );

    console.log("Running server")
    server.start();
}

main();