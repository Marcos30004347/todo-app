import { HelloRequest } from "@codegen/pb/user/v1/user_pb"
import { UserClient } from "@codegen/pb/user/v1/user_grpc_pb";

import { credentials, ServiceError } from 'grpc'
import { HelloReply } from "@codegen/pb/auth/v1/auth_pb";
// import fs from "fs";
// import path from "path";

function main() {
  const client = new UserClient('localhost:30052', credentials.createInsecure());
    // credentials.createSsl(
    //   fs.readFileSync(path.join(process.cwd(), "certs", "ca.crt")),
    //   fs.readFileSync(path.join(process.cwd(), "certs", "client.key")),
    //   fs.readFileSync(path.join(process.cwd(), "certs", "client.crt")),
    // )
    
  const request = new HelloRequest();

  request.setName("marcos");

  client.sayHello(request, function(_: ServiceError | null, response: HelloReply) {
    console.log('Greeting:', response.getMessage());
  });
}

main();