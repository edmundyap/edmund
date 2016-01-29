# What classes do you need?

# Remember, there are four high-level responsibilities, each of which have multiple sub-responsibilities:
# 1. Gathering user input and taking the appropriate action (controller)
# 2. Displaying information to the user (view)
# 3. Reading and writing from the todo.txt file (model)
# 4. Manipulating the in-memory objects that model a real-life TODO list (domain-specific model)

# Note that (4) is where the essence of your application lives.
# Pretty much every application in the universe has some version of responsibilities (1), (2), and (3).
# require 'byebug'
require 'CSV'

class Task
  #id, the task itself, status of task
  attr_accessor :id, :task, :status

  def initialize(data = {})
    @id = data.fetch(:id){nil}
    @task = data.fetch(:task)
    @status = data.fetch(:status){false}
  end

  def change_task(change)
    @task = change
  end

  def self.completed(task)
    task.status= true
    # @status = true
  end
end


class List
attr_accessor :task_list
  def initialize
    @task_list = []
  end

  def read_task_list
    starting_id = 1
    CSV.foreach("TODO/todo.csv") do |row|
      row = Task.new(id: starting_id, task: row[0])
      @task_list << row
      starting_id += 1
    end
  end

  def add_task(task)
    id = @task_list.length + 1
    new_task = Task.new(id: id, task: task)
    @task_list << new_task
  end

  def delete_task(id)
    @task_list.delete_at(id-1)
  end
# byebug
  def completed_task(task_id)
    task = @task_list[task_id-1]
    Task.completed(task) #why cant i invoke a .completed method on it?
  end

  def update
    @task_list.each_with_index do |task, i|
      task.id = i+1
    end

    @task_list.each do |task|
      puts "#{task.id}) #{task.task} #{task.status}."
    end
  end

end



list = List.new
list.read_task_list
list.add_task("eat maggi mee")
list.update
list.delete_task(1)
list.update
list.completed_task(13)
list.update
