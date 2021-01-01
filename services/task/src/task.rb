#!/usr/bin/ruby

require 'task-manager'

class Task
    def initialize(id, user, title, description, due_date, state)
        @description = description
        @title = title
        @id = id
        @user = user
        @due_date = due_date
    end
    private_class_method :new

    # Create a task object    
    def self.create(user, title, description, due_date)
        id = TaskManager.create_task(user, title, description, due_date)
        new(id, user, title, description, due_date, 0)
    end

    # Loads one task object by id
    def self.load(id)
        doc = TaskManager.find_task(id)
        new(doc[:_id], doc[:user], doc[:title], doc[:description], doc[:due_date], doc[:state])
    end

    # Return the task title
    def title; @title; end

    # Update the task title
    def title=(new_title)
        TaskManager.update_task_title(@id, new_title)
        @title = new_title
    end

    # Return the task description
    def description; @description; end

    # Update the Task description
    def description=(new_description)
        TaskManager.update_task_description(@id, new_description)
        @description = new_description
    end

    # Return the task state
    def state; @state; end
    
    # Update the task state
    def state=(new_state)
        TaskManager.update_task_state(@id, new_state)
        @state = new_state
    end

    # Return the task due date
    def due_date; @due_date; end

    # Update the task due date
    def due_date=(new_due_date)
        TaskManager.update_new_due_date(@id, new_due_date)
        @due_date = new_due_date
    end

    # Return the task id
    def id; @id; end
end