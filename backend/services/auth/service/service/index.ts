import { Network } from '@auth/network'
import { Database } from '@auth/database'

class AuthService {
    private network     :Network
    private database    :Database

    constructor(){
        this.network = new Network();
        this.database = new Database("mongodb://authdb:27017");
    }

    public async init(): Promise<void> {
        await this.database.connect();
    }

    public async run(): Promise<void> {
        await this.network.run();
    }
}

export {
    AuthService
}