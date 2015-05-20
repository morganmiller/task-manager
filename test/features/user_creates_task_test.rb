require_relative '../test_helper'

class CreateTaskTest < FeatureTest
  
  def test_user_can_find_create_task_page
    visit "/"
    within ("#primary-nav") do
      click_link("New Task")
      assert_equal "/tasks/new", current_path
    end
  end

  def test_user_can_create_a_task
    visit "/tasks/new"
    fill_in('task[title]',
              with: 'test')
    fill_in('task[description]',
              with: 'do the things')
    click_link_or_button('submit')
    visit "/tasks"
    assert page.has_content?("test")
  end
  
end
