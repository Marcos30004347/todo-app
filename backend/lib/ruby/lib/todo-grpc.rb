#!/usr/bin/ruby
# https://serverfault.com/questions/968343/why-do-i-need-a-certificate-to-establish-a-secure-grpc-connection-as-a-client
# https://github.com/grpc/grpc/blob/master/src/ruby/spec/channel_credentials_spec.rb
# https://bbengfort.github.io/programmer/2017/03/03/secure-grpc.html#:~:text=gRPC%20has%20SSL%2FTLS%20integration,provide%20certificates%20for%20mutual%20authentication.

require 'grpc'

class GRPCServer
    def initialize(handler, url, certs = nil)
        @server = GRPC::RpcServer.new

        if certs 
            creds = GRPC::Core::ServerCredentials.new(certs[0], [{ private_key: certs[1], cert_chain: certs[2] }], true)
            @server.add_http2_port(url, creds)
        else
            @server.add_http2_port(url, :this_port_is_insecure)
        end
    
        @server.handle(handler)
    end

    def run
        @server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
    end
end


class GRPCConnection
    def initialize(url, certs = nil)
        creds = GRPC::Core::ChannelCredentials.new(certs[0], certs[1], certs[2])
        @stub = Helloworld::Greeter::Stub.new(url, creds)
    end

    # def add_endpoint(method)
    #     define_singleton_method("#{method}") do |*args|
    #         @stub.send(method, *args)
    #     end
    # end

    def client; @stub; end
end


