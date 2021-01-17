import { HelloReply, HelloRequest } from '@codegen/pb/auth/v1/auth_pb'
import { AuthService, IAuthServer } from '@codegen/pb/auth/v1/auth_grpc_pb'

import { ServerUnaryCall, sendUnaryData, Server, ServerCredentials } from 'grpc'


class Handler implements IAuthServer {
    public sayHello(call: ServerUnaryCall<HelloRequest>, callback: sendUnaryData<HelloReply>) : void {
      const reply = new HelloReply();
      reply.setMessage('Hello ' + call.request.getName());
      callback(null, reply);
    }
}

class GRPCServer {
    private server: Server;
    private port: number;
  
    constructor(port :number) {
      this.port = port;
      this.server = new Server();
      this.server.addService(AuthService, new Handler());
    }

    public async run(): Promise<void> {
      await this.server.bind(`0.0.0.0:${this.port}`, ServerCredentials.createInsecure());
      //  ServerCredentials.createSsl(
      //       fs.readFileSync(path.join(process.cwd(), "certs", "ca.crt")),
      //       [{
      //           private_key: fs.readFileSync(path.join(process.cwd(), "certs", "server.key")),
      //           cert_chain: fs.readFileSync(path.join(process.cwd(), "certs", "server.crt")),
      //       }],
      //       true
      //   )
    
      console.log("Running server")
      await this.server.start();
      return;
    }
}

export {
    GRPCServer
};