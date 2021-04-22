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

  it 'is invalid with a duplicate email address' do
    FactoryBot.create(:user, email: 'duplicate@example.com')
    user = FactoryBot.build(:user, email: 'duplicate@example.com')
    expect(user).to be_invalid
  end

  it 'is invalid without a password' do
    user.password = ' ' * 8
    expect(user).to be_invalid
  end

  it 'is invalid without passwords more than 8 characters' do
    user.password = 'a' * 7
    expect(user).to be_invalid
  end
end
