require "rails_helper"

RSpec.describe ProductMailer, type: :mailer do
  describe "in_stock" do
    let(:mail) { ProductMailer.in_stock }

    it "renders the headers" do
      expect(mail.subject).to eq("In stock")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
