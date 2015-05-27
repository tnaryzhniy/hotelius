require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }

  describe 'respond tests' do
    subject {user}

    it { should respond_to(:id) }
    it { should respond_to(:email) }
    it { should respond_to(:encrypted_password) }
    it { should be_valid }
  end

  describe 'validation tests' do
    subject {user}

    it 'id is not present' do
      user.id = ''
      should_not be_valid
    end

    describe 'email tests' do
      it 'email is not present' do
        user.email = ''
        should_not be_valid
      end

      describe 'email format is invalid' do
        it 'should be invalid' do
          email = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
          email.each do |invalid_email|
            user.email = invalid_email
            user.should_not be_valid
          end
        end
      end

      describe 'email format is valid' do
        it 'should be valid' do
          email = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
          email.each do |valid_email|
            user.email = valid_email
            expect(user).to be_valid
          end
        end
      end

      it 'email address is already taken' do
        user_with_same_email = user.dup
        user_with_same_email.save
        user_with_same_email.should_not be_valid
        user_with_same_email.email = user.email.upcase
        user_with_same_email.should_not be_valid
      end

      describe 'email with mixed case' do
        let(:mixed_case_email) { 'Foo@ExAMPle.CoM' }

        it 'should be saved as all lower-case' do
          user.email = mixed_case_email
          user.save
          expect(user.reload.email).to eq mixed_case_email.downcase
        end
      end
    end

    describe 'password tests' do
      it 'password is not present' do
        user.encrypted_password = user.password_confirmation = ''
        should_not be_valid
      end

      it 'password does not match confirmation' do
        user.password_confirmation = 'mismatch'
        should_not be_valid
      end

      it 'password is too short' do
        user.encrypted_password = user.password_confirmation = 'z' * 5
        should be_invalid
      end
    end
  end


end
