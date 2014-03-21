require 'spec_helper'

describe 'User Sign Up' do 
  let!(:user) { FactoryGirl.attributes_for(:user) }
  context 'with valid and unique information' do
    it 'allows the user to be created' do
      visit new_user_registration_path
      fill_in "user[first_name]", with: user[:first_name]
      fill_in "user[last_name]", with: user[:last_name]
      fill_in "user[profile_name]", with: user[:profile_name]
      fill_in "user[email]", with: user[:email]
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'
      expect { click_on 'Sign Up' }.to change{ User.count }
    end
  end
  context 'with incomplete information' do
    it 'does not allow the user to be created' do
      visit new_user_registration_path
      fill_in "user[first_name]", with: user[:first_name]
      fill_in "user[last_name]", with: user[:last_name]
      fill_in "user[profile_name]", with: user[:profile_name]
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'
      expect { click_on 'Sign Up' }.not_to change{ User.count }
    end
  end
end