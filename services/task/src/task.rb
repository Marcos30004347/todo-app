#!/usr/bin/ruby

class Task
    def create(user, title, description, due_date)
        @due_date       = due_date
        @title          = title
        @user           = user
        @description    = description
    end

    private_class_method :new
    # def self.create(user, title, description, due_date)
    #     doc = TaskManager.create_task(user, title, description, due_date).inserted_id
    #     @id     = doc[:id];
    #     @user   = doc[:user];
    #     @user   = doc[:title];
    #     @user   = doc[:description];
    #     @user   = doc[:due_date];
    # end

    # def self.load(id)
    #     doc = TaskManager.find_task(id)

    #     @id     = doc[:id];
    #     @user   = doc[:user];
    #     @user   = doc[:title];
    #     @user   = doc[:description];
    #     @user   = doc[:due_date];
    # end



end