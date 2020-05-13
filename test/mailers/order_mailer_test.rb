require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OrderMailer.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal ["dave@anydomain.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /2 x The One Book Title/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderMailer.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal ["dave@anydomain.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /<td[^>]*>2<\/td>\s*<td>The One Book Title<\/td>/, mail.body.encoded
  end

end
