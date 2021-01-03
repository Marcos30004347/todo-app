import { HelloRequest } from "@lib/helloworld_pb"
import { GreeterClient } from '@lib//helloworld_grpc_pb';

import { credentials } from 'grpc'

function main() {
    var client = new GreeterClient('localhost:8080', credentials.createInsecure());
    
    var request = new HelloRequest();

    request.setName("marcos");

    client.sayHello(request, function(err: any, response: any) {
      console.log('Greeting:', response.getMessage());
    });
  }

main();