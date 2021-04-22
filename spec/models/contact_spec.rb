require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { FactoryBot.create(:contact) }

  it 'has a valid factory' do
    expect(contact).to be_valid
  end

  it 'is invalid without a name' do
    contact.name = ""
    expect(contact).to be_invalid
  end

  it 'does not have too long name' do
    contact.name = 'a' * 31
    expect(contact).to be_invalid
  end

  it 'is invalid without an email' do
    contact.email = ""
    expect(contact).to be_invalid
  end

  it 'does not have too long email' do
    long_email = 'a' * 244
    contact.email = "#{long_email}@example.com"
    expect(contact).to be_invalid
  end

  it 'has invalid email addresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      contact.email = invalid_address
      expect(contact).to be_invalid, "#{invalid_address.inspect} should be invalid."
    end
  end

  it 'is invalid without a message' do
    contact.message = ""
    expect(contact).to be_invalid
  end

  it 'does not have too long message' do
    contact.message = 'a' * 2001
    expect(contact).to be_invalid
  end
end
