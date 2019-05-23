require 'rails_helper'

describe 'As an admin' do
  describe 'when I visit / I see link to add a project' do
    describe 'when I click it I can create a new project' do
      user = User.new
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/'
      click_link 'Add Project'

      expect(current_path).to eq(admin_new_project_path)

      fill_in 'Title', with: 'Test Project'
      fill_in 'Date', with: 10.days.from_now
      fill_in 'Description', with: 'The testiest of all test projects.'
      fill_in 'Line 1', with: '1331 17th St'
      fill_in 'Line 2', with: 'LL100'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip', with: '80202'
      fill_in 'Image', with: 'https://www.historycolorado.org/sites/default/files/media/images/2018/pikes-peak-1273566_1920.jpg'
      click 'Create Project'

      project = Project.last
      expect(current_path).to eq(project_path(project))
      expect(page).to have_content("Your project was successfully created!")
      expect(page).to have_content(project.title)
    end
  end
end
