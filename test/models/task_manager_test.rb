require_relative '../test_helper'

class TaskManagerTest < Minitest::Test
  
  ####Change tests so they are not dependent on the ID
      ##So instead of using TaskManager.create, use Task.new and store the task

  def create_tasks(num)
    num.times do |x|
      TaskManager.create({ :title       => "task#{x+1}",
                           :description => "#{x+1}"})
    end
  end
  
  def test_it_creates_a_task
    create_tasks(1)
    task = TaskManager.all.last
    
    assert_equal "task1", task.title
    assert_equal "1", task.description
  end

  def test_it_shows_all_tasks
    create_tasks(2)
    
    tasks = TaskManager.all
    
    assert_equal 2, tasks.count
    assert tasks[0].is_a?(Task)
  end

  def test_it_finds_a_task
    create_tasks(2)
    
    task1 = TaskManager.all[-2]
    task2 = TaskManager.all.last

    assert_equal "task1", task1.title
    assert_equal "2", task2.description
  end

  def test_it_can_update_a_task
    create_tasks(1)
    
    task = TaskManager.all.last
    
    assert_equal "task1", task.title
    assert_equal "1", task.description
    
    data = {:title       => "new title",
            :description => "new description"} 
    TaskManager.update(task.id, data)
    
    task = TaskManager.all.last
    
    assert_equal "new title", task.title
    assert_equal "new description", task.description
  end

  def test_it_can_destroy_a_task
    create_tasks(1)
    count = TaskManager.all.count
    task = TaskManager.all.last
    
    assert_equal count, TaskManager.all.count
    
    TaskManager.destroy(task.id)
    
    assert_equal count - 1, TaskManager.all.count
  end
end

