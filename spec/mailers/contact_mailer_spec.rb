require "rails_helper"

RSpec.describe ContactMailer, type: :mailer do
  let(:contact) { FactoryBot.create(:contact) }
  let(:mail) { ContactMailer.send_mail(contact) }

  it 'renders the headers' do
    expect(mail.subject).to eq('【お問い合わせ】')
    expect(mail.to).to eq([ENV['LYBODYMAIL']])
    expect(mail.from).to eq(['noreply-lybody@example.com'])
  end

  it 'renders the body' do
    expect(mail.text_part.body.encoded).to match "#{contact.name} 様 から問い合わせがありました。"
    expect(mail.html_part.body.encoded).to match "#{contact.name} 様 から問い合わせがありました。"
    expect(mail.text_part.body.encoded).to match "【メールアドレス】: #{contact.email}"
    expect(mail.html_part.body.encoded).to match "【メールアドレス】: #{contact.email}"
    expect(mail.text_part.body.encoded).to match contact.message
    expect(mail.html_part.body.encoded).to match contact.message
  end
end
