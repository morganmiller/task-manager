require_relative '../test_helper'

class TaskManagerTest < Minitest::Test

  def create_tasks(num)
    num.times do |x|
      TaskManager.create({ :title       => "task#{x+1}",
                           :description => "#{x+1}"})
    end
  end
  
  def test_it_creates_a_task
    create_tasks(1)
    
    task = TaskManager.find(1)
    
    assert_equal "task1", task.title
    assert_equal "1", task.description
    assert_equal 1, task.id
  end

  def test_it_shows_all_tasks
    create_tasks(2)
    
    tasks = TaskManager.all
    task = TaskManager.find(2)
    
    assert_equal 2, tasks.count
    assert tasks[0].is_a?(Task)
    assert_equal task.id, tasks[1].id
  end

  def test_it_finds_a_task
    create_tasks(2)
    
    task1 = TaskManager.find(1)
    task2 = TaskManager.find(2)

    assert_equal "task1", task1.title
    assert_equal "2", task2.description
  end

  def test_it_can_update_a_task
    create_tasks(1)
    
    task = TaskManager.find(1)
    
    assert_equal "task1", task.title
    assert_equal "1", task.description
    
    data = {:title       => "new title",
            :description => "new description"}
    TaskManager.update(1, data)
    
    task = TaskManager.find(1)
    
    assert_equal "new title", task.title
    assert_equal "new description", task.description
  end

  def test_it_can_destroy_a_task
    create_tasks(1)
    count = TaskManager.all.count
    
    assert_equal count, TaskManager.all.count
    
    TaskManager.destroy(1)
    
    assert_equal count - 1, TaskManager.all.count
  end
end

