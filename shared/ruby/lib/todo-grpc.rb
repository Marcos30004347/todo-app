#!/usr/bin/ruby
# https://serverfault.com/questions/968343/why-do-i-need-a-certificate-to-establish-a-secure-grpc-connection-as-a-client
# https://github.com/grpc/grpc/blob/master/src/ruby/spec/channel_credentials_spec.rb
# https://bbengfort.github.io/programmer/2017/03/03/secure-grpc.html#:~:text=gRPC%20has%20SSL%2FTLS%20integration,provide%20certificates%20for%20mutual%20authentication.

class GRPCServer
    # def self.inherited(subclass)
    #     @subclass = subclass
    # end

    # def add_endpoint(name, handler)
    #     define_method(:my_method) do |foo, bar| # or even |*args|
    #         handler(hello_req)
    #     end
    # end

    def initialize(handler, url)
        @server = GRPC::RpcServer.new
        @server.add_http2_port(url, :this_port_is_insecure)
        @server.handle(handler)
    end

    def run
        @server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
    end
end


class GRPCClient
    def initialize(url)
        @stub = Helloworld::Greeter::Stub.new(url, :this_channel_is_insecure)
    end

    def add_endpoint(method)
        define_singleton_method("#{method}") do |*args|
            @stub.send(method, *args)
        end
    end

    def stub; @stub; end
end


