require 'rails_helper'

RSpec.feature 'Login page', type: :feature do
  background { visit new_user_session_path }
  scenario 'displays form fields' do
    expect(page).to have_field('user_email')
    expect(page).to have_field('user_password')
    expect(page).to have_button('Log in')
  end

  describe 'login page' do
    scenario 'If the form submitted is empty' do
      click_button 'Log in'
      expect(page).to have_content "Forgot your password? Didn't receive confirmation instructions?"
    end

    scenario 'Submitting form with the incorrect email and password' do
      visit new_user_session_path
      fill_in 'Email', with: 'candy@gmail.com'
      fill_in 'Password', with: ''
      click_button 'Log in'
      expect(page).to have_content "Forgot your password? Didn't receive confirmation instructions?"
    end

    scenario 'Submitting form with the correct email and password' do
      @user = User.create(name: 'kandy Peter', email: 'candy@gmail.com', password: '123456', bio: 'Iam a software developer',
                          photo: 'https://candy.com', posts_counter: 0)
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
    end
  end
end
