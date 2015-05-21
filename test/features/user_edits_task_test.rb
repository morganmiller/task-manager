require_relative '../test_helper'

class EditTaskTest < FeatureTest

  def test_user_can_edit_task
    TaskManager.create(title: "practice", description: "tonight")
    visit '/tasks'
    click_link('Edit')
    
    task = TaskManager.all.last
    
    assert_equal "/tasks/#{task.id}/edit", current_path
    
    fill_in 'task[title]', with: 'tomorrow'
    fill_in 'task[description]', with: 'sequel'
    click_link_or_button "Update Task"
    
    assert page.has_content?("tomorrow")
    assert page.has_content?("sequel")
  end

end
