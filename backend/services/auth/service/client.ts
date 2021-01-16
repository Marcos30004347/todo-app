import { HelloRequest } from "./codegen/pb/helloworld_pb"
import { GreeterClient } from './codegen/pb/helloworld_grpc_pb';

import { credentials } from 'grpc'
// import fs from "fs";
// import path from "path";

function main() {
  let client = new GreeterClient('localhost:8080',
    credentials.createInsecure()
  // credentials.createSsl(
  //   fs.readFileSync(path.join(process.cwd(), "certs", "ca.crt")),
  //   fs.readFileSync(path.join(process.cwd(), "certs", "client.key")),
  //   fs.readFileSync(path.join(process.cwd(), "certs", "client.crt")),
  // )
  );
  
  let request = new HelloRequest();

  request.setName("marcos");

  client.sayHello(request, function(err: any, response: any) {
    console.log('Greeting:', response.getMessage());
  });
}

main();