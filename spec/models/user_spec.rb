require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'has a valid factory' do
    expect(user).to be_valid
  end

  it 'is invalid without a firstname' do
    user.firstname = ""
    expect(user).to be_invalid
  end

  it 'does not have too long firstname' do
    user.firstname = 'a' * 16
    expect(user).to be_invalid
  end

  it 'is invalid without a lastname' do
    user.lastname = ""
    expect(user).to be_invalid
  end

  it 'does not have too long lastname' do
    user.lastname = 'a' * 16
    expect(user).to be_invalid
  end

  it 'is invalid without a kana_firstname' do
    user.kana_firstname = ""
    expect(user).to be_invalid
  end

  it 'does not have too long kana_firstname' do
    user.kana_firstname = 'a' * 16
    expect(user).to be_invalid
  end

  it 'is invalid except for Katakana to kana_firstname' do
    invalid_kana_firstnames = %w[furigana フリガナ+ /jカナ]
    invalid_kana_firstnames.each do |kana|
      user.kana_firstname = kana
      expect(user).to be_invalid, "#{kana.inspect} should be invalid"
    end
  end

  it 'is invalid without a kana_lastname' do
    user.kana_lastname = ""
    expect(user).to be_invalid
  end

  it 'does not have too long kana_lastname' do
    user.kana_lastname = 'a' * 16
    expect(user).to be_invalid
  end

  it 'is invalid except for Katakana to kana_lastname' do
    invalid_kana_lastnames = %w[furigana フリガナ+ /jカナ]
    invalid_kana_lastnames.each do |kana|
      user.kana_lastname = kana
      expect(user).to be_invalid, "#{kana.inspect} should be invalid"
    end
  end

  it 'is invalid without an email' do
    user.email = ""
    expect(user).to be_invalid
  end

  it 'does not have too long email' do
    long_email = 'a' * 244
    user.email = "#{long_email}@example.com"
    expect(user).to be_invalid
  end

  it 'is invalid with a duplicate email' do
    FactoryBot.create(:user, email: 'duplicate@example.com')
    user = FactoryBot.build(:user, email: 'duplicate@example.com')
    expect(user).to be_invalid
  end

  it 'has invalid email' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to be_invalid, "#{invalid_address.inspect} should be invalid."
    end
  end

  it 'is invalid without a password' do
    user.password = ' ' * 8
    expect(user).to be_invalid
  end

  it 'is invalid without passwords more than 8 characters' do
    user.password = 'a' * 7
    expect(user).to be_invalid
  end

  it 'is invalid without a phone_number' do
    user.phone_number = ""
    expect(user).to be_invalid
  end

  it 'has invalid phone_number' do
    invalid_phone_numbers = %w[111222233333 111222233 111222233 11122223 1112222 111222 11122 1112 111 11 1 １１１２２２２３３３３ １１２２２２３３３３]
    invalid_phone_numbers.each do |invalid_phone_number|
      user.phone_number = invalid_phone_number
      expect(user).to be_invalid, "#{invalid_phone_number.inspect} should be invalid."
    end
  end

  it 'is invalid when is_payed is nil' do
    user.is_payed = nil
    expect(user).to be_invalid
  end

  it 'is valid when is_payed is true' do
    user.is_payed = true
    expect(user).to be_valid
  end

  it 'is valid when is_payed is false' do
    user.is_payed = false
    expect(user).to be_valid
  end

  it 'is invalid when is_valid is nil' do
    user.is_valid = nil
    expect(user).to be_invalid
  end

  it 'is valid when is_valid is true' do
    user.is_valid = true
    expect(user).to be_valid
  end

  it 'is valid when is_valid is false' do
    user.is_valid = false
    expect(user).to be_valid
  end
end
