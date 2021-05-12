require 'rails_helper'

RSpec.describe Instructor, type: :model do
  let(:instructor) { FactoryBot.create(:instructor) }

  it 'has a valid factory' do
    expect(instructor).to be_valid
  end

  it 'is invalid without a name' do
    instructor.name = ''
    expect(instructor).to be_invalid
  end

  it 'does not have too long name' do
    instructor.name = 'a' * 31
    expect(instructor).to be_invalid
  end

  it 'is invalid without an email' do
    instructor.email = ''
    expect(instructor).to be_invalid
  end

  it 'does not have too long email' do
    long_email = 'a' * 244
    instructor.email = "#{long_email}@example.com"
    expect(instructor).to be_invalid
  end

  it 'is invalid with a duplicate email' do
    FactoryBot.create(:instructor, email: 'duplicate@example.com')
    instructor = FactoryBot.build(:instructor, email: 'duplicate@example.com')
    expect(instructor).to be_invalid
  end

  it 'has invalid email' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com
                           foo@bar..com]
    invalid_addresses.each do |invalid_address|
      instructor.email = invalid_address
      expect(instructor).to be_invalid, "#{invalid_address.inspect} should be invalid."
    end
  end

  it 'is invalid without a password' do
    instructor.password = ' ' * 8
    expect(instructor).to be_invalid
  end

  it 'is invalid without passwords more than 8 characters' do
    instructor.password = 'a' * 7
    expect(instructor).to be_invalid
  end

  it 'is invalid without an instructor_image' do
    instructor.instructor_image = ''
    expect(instructor).to be_invalid
  end

  it 'is invalid when has_lesson is nil' do
    instructor.has_lesson = nil
    expect(instructor).to be_invalid
  end

  it 'is valid when has_lesson is true' do
    instructor.has_lesson = true
    expect(instructor).to be_valid
  end

  it 'is valid when has_lesson is false' do
    instructor.has_lesson = false
    expect(instructor).to be_valid
  end

  it 'is invalid without a comment' do
    instructor.comment = ''
    expect(instructor).to be_invalid
  end

  it 'does not have too long comment' do
    instructor.comment = 'a' * 301
    expect(instructor).to be_invalid
  end
end
