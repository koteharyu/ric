require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with username, email, pass, pass_con' do

    end

    it 'is invalid without username' do

    end

    it 'is invalid without email' do

    end

    it 'is invalid without password' do

    end

    it 'is invalid without pass_con' do

    end

    it 'is invalid with same email' do

    end
  end

  describe 'instance methods' do

    describe 'own?' do
      it 'returns true when user.own? user_post' do

      end

      it 'returns false when user.own? other_post' do

      end
    end
  end

  describe 'like' do
    it 'likes other post' do

    end

    it 'unlike other post' do

    end

    it 'is true that user like other post' do

    end

    it 'is false that user like other post' do

    end
  end

  describe 'follow' do
    it 'is increasing other_user.followers for user follow other user' do

    end

    it '' do
      
    end
  end

end
