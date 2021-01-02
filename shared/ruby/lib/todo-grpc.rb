#!/usr/bin/ruby
# https://serverfault.com/questions/968343/why-do-i-need-a-certificate-to-establish-a-secure-grpc-connection-as-a-client
# https://github.com/grpc/grpc/blob/master/src/ruby/spec/channel_credentials_spec.rb
# https://bbengfort.github.io/programmer/2017/03/03/secure-grpc.html#:~:text=gRPC%20has%20SSL%2FTLS%20integration,provide%20certificates%20for%20mutual%20authentication.

require 'grpc'

class GRPCServer
    # def self.inherited(subclass)
    #     @subclass = subclass
    # end

    # def add_endpoint(name, handler)
    #     define_method(:my_method) do |foo, bar| # or even |*args|
    #         handler(hello_req)
    #     end
    # end
    def load_test_certs
        test_root = File.join(File.dirname(__FILE__), 'testdata')
        files = ['ca.pem', 'server1.key', 'server1.pem']
        files.map { |f| File.open(File.join(test_root, f)).read }
    end
    
    def initialize(handler, url)
        this_dir = File.expand_path(File.dirname(__FILE__))
        certs_dir = File.join(this_dir, '../certs')

        files = ['ca.pem', 'server.key', 'server.pem']
        certs = files.map { |f| File.open(File.join(certs_dir, f)).read }

        creds = GRPC::Core::ServerCredentials.new(certs[0], [{ private_key: certs[1], cert_chain: certs[2] }], true)
        @server = GRPC::RpcServer.new
        @server.add_http2_port(url, creds)
        @server.handle(handler)
    end

    def run
        @server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
    end
end


class GRPCClient
    def initialize(url)
        this_dir = File.expand_path(File.dirname(__FILE__))
        certs_dir = File.join(this_dir, '../certs')

        files = ['ca.pem', 'client.key', 'client.pem']
        certs = files.map { |f| File.open(File.join(certs_dir, f)).read }
    
        creds = GRPC::Core::ChannelCredentials.new(certs[0], certs[1], certs[2])
        @stub = Helloworld::Greeter::Stub.new(url, creds)
    end

    def add_endpoint(method)
        define_singleton_method("#{method}") do |*args|
            @stub.send(method, *args)
        end
    end

    def stub; @stub; end
end


