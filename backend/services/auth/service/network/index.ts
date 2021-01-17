import { RESTServer } from "./rest"
import { GRPCServer } from "./grpc"

class Network {
    private grpc_server: GRPCServer
    private rest_server: RESTServer

    constructor(){
        this.rest_server = new RESTServer(10051);
        this.grpc_server = new GRPCServer(10052);
    }

    public async run(): Promise<void> {
        await Promise.all([
            this.grpc_server.run(),
            this.rest_server.run()
        ])
    }
}

export {
    Network
}