require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "send_confirmation" do
    mail = OrderMailer.send_confirmation
    assert_equal "Send confirmation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
