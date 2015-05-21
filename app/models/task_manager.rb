require 'yaml/store'

class TaskManager
  def self.database
    if ENV["TASK_MANAGER_ENV"] == 'test'
      @database ||= Sequel.sqlite('db/task_manager_test.sqlite3')
    else
      @database ||= Sequel.sqlite('db/task_manager_dev.sqlite3')
    end
  end
  
  def self.dataset
    database.from(:tasks)
  end

  def self.create(task)
    dataset.insert(:title => task[:title], :description => task[:description])
  end

  def self.raw_tasks
    database.transaction do
      database['tasks'] || []
    end
  end

  def self.all
    dataset.map do |data|
      Task.new(data)
    end
  end

  def self.raw_task(id)
    raw_tasks.find { |task| task["id"] == id }
  end

  def self.find(id)
    task = dataset.where(:id => id)
    Task.new(task.to_a[0])
  end
  
  def self.update(id, data)
    dataset.where(:id => id).update(data)
  end
  
  def self.destroy(id)
    dataset.where(:id => id).delete
  end
  
  def self.delete_all
    dataset.delete
  end
end
