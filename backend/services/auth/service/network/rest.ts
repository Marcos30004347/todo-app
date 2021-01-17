import express, { Request, Response , Application }  from "express";

const PORT = 8000;

class RESTServer {
    server: Application
    port: number

    constructor(port: number){
        this.server = express();
        this.port = port

        this.server.get('/', (req: Request, res: Response) => res.send('Express + TypeScript Server'));
    }

    public async run(): Promise<void>{
        await this.server.listen(PORT);
        return;
    }
}


export {
    RESTServer
}