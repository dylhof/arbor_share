require 'rails_helper'

RSpec.describe 'as a logged in user' do
  context 'on my profile page' do
    before :each do
      @organizer = User.create(full_name: 'Project Organizer',
                              email: 'organizer@email.com',
                              about: 'A little about myself, very little',
                              avatar_image: 'link to image',
                              google_token: 'google token',
                              google_id: 1,
                              role: 1,
                              active: true)

      @user = User.create(full_name: 'Project Organizer',
                              email: 'organizer@email.com',
                              about: 'A little about myself, very little',
                              avatar_image: 'link to image',
                              google_token: 'google token',
                              google_id: 1,
                              role: 1,
                              active: true)

      @project1 = Project.create(title: 'Project 1',
                                  date: '2019-03-30', 
                                  description: 'Description of Project 1',
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  organizer: @user,
                                  active: true)

      @project2 = Project.create(title: 'Project 2',
                                  date: '2019-04-30', 
                                  description: 'Description of Project 2',
                                  image: 'http://clipart-library.com/image_gallery/104074.png',
                                  organizer: @user,
                                  active: true)

      @project3 = Project.create(title: 'Project 3',
                            date: '2019-06-30', 
                            description: 'Description of Project 3',
                            image: 'http://clipart-library.com/image_gallery/104074.png',
                            organizer: @user,
                            active: true)

      @project4 = Project.create(title: 'Project 3',
                            date: '2019-07-30', 
                            description: 'Description of Project 4',
                            image: 'http://clipart-library.com/image_gallery/104074.png',
                            organizer: @user,
                            active: true)

      @address1 = Address.create(owner: @project1,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)

      @address2 = Address.create(owner: @project2,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)

      @address3 = Address.create(owner: @user,
                              line_1: "first address line",
                              line_2: "second address line",
                              city: "city town",
                              state: 0,
                              zip: '12345',
                              default: true)

      visit profile_path
    end

    it 'can see all of the users information' do
      # expect(page).to have_content(@user.avatar_image)
      expect(page).to have_content(@user.full_name)

      within '.about-me' do
        expect(page).to have_content(@user.about)
      end

      within '.user-info' do
        #last project completed?
        expect(page).to have_content("Number of projects participated in: #{@user.projects.count}")
        expect(page).to have_content("Member Since: #{@user.created_at}")
      end

      within '.upcoming-projects' do
        #last project completed?
        expect(page).to have_content('Upcoming Projects')
        expect(page).to have_link(@project3.title)
        expect(page).to have_link(@project4.title)
      end
      expect(page).to have_button('Edit Profile')
    end

    it 'can see default address' do
      # must be logged in
      within '.default' do
        within '.address' do
          expect(page).to have_content(@address3.first_line)
          expect(page).to have_content(@address3.second_line)
          expect(page).to have_content(@address3.city)
          expect(page).to have_content(@address3.state)
          expect(page).to have_content(@address3.zip)
        end
      end
    end

    it 'can see default vehicle' do
      within '.default' do
        within '.vehicle' do
          expect(page).to have_content("Make: #{@vehicle.make}")
          expect(page).to have_content("Model: #{@vehicle.model}")
          expect(page).to have_content("Color: #{@vehicle.color}")
          expect(page).to have_content("Number of Passengers: #{@vehicle.passenger_limit}")
          expect(page).to have_content("Year: #{@vehicle.year}")
          # Test for image?
          # expect(page).to have_content(@vehicle.image)
        end
      end
    end
  end
end
