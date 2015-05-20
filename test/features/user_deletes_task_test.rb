require_relative '../test_helper'

class DeleteTaskTest < FeatureTest

  def test_user_can_delete_task
    TaskManager.create(title: "practice", description: "tonight")
    visit '/tasks'
    click_link_or_button('delete')
    refute page.has_content?("practice")
  end

end
