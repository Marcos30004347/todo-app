#!/usr/bin/ruby

require 'mongo'

module MongoDB


class Collection
    @collection;

    def initialize(coll)
        @collection = coll
    end

    def insert_one(document)
        @collection.insert_one(document)
    end

    def insert_many(documents)
        @collection.insert_many(documents)
    end

    def find(query)
        @collection.find(query)
    end

    def aggregate(pipeline)
        @collection.aggregate(pipeline)
    end

    def update_many(query, update)
        @collection.update_many(query, update)
    end

    def update_one(query, update)
        @collection.update_one(query, update)
    end

    def delete_one(query)
        @collection.delete_one(query, update)
    end

    def delete_many(query)
        @collection.delete_many(query, update)
    end
end
class Client
    def initialize(url, db)
        @client = Mongo::Client.new([url], database: db)
    end

    def collection(coll)
        @database = @client.database
        ToDo::MongoDB::Collection.new(@client[coll])
    end
end
end
