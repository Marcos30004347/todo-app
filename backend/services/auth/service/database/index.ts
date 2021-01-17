import { MongoClient, Collection , Db } from "mongodb"

interface Session {
    user    :string
    token   :string
}

class Database {
    private client      :MongoClient
    private database    :Db
    private collection  :Collection<Session>

    constructor(uri: string){
        this.client = new MongoClient(uri);     
    }
    
    async connect(): Promise<void> {
        await this.client.connect();
        this.database = this.client.db('auth');
        this.collection = this.database.collection('sessions');
    }

    async close(): Promise<void> {
        await this.client.close()
    }

}

export {
    Database
}
