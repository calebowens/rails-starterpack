require "application_rack_test"

class SubmissionTest < ApplicationRackTest
  include_phlex_helpers

  test ".blank returns a valid submission" do
    submission = Submission.blank

    assert submission.valid?
  end

  test "it delegates to the argument" do
    submission = Submission.new({target: "asdf"})

    assert_equal submission.dig(:target), "asdf"
  end

  test "#present validator should add an error when the value isn't present" do
    submission = Submission.new({target: ""})

    submission.ensures_present(:target)

    refute submission.valid?
  end

  test "#present validator should be valid when there is a present value" do
    submission = Submission.new({target: "asdf"})

    submission.ensures_present(:target)

    assert submission.valid?
  end

  test "#valid_email validator should be valid when there is a valid email" do
    submission = Submission.new({target: "hello@example.com"})

    submission.ensures_valid_email(:target)

    assert submission.valid?
  end

  test "#valid_email validator should not valid when there is an invlaid email" do
    submission = Submission.new({target: "asdfasdf"})

    submission.ensures_valid_email(:target)

    refute submission.valid?
  end

  test "#ensure validator should be valid when the proc is true" do
    submission = Submission.new({target: "asdfasdf"})

    submission.ensure(:target, message: "Proc failed") { _1 == "asdfasdf" }

    assert submission.valid?
  end

  test "#ensure validator should be not valid when the proc is false" do
    submission = Submission.new({target: "foobarbaz"})

    submission.ensure(:target, message: "Proc failed") { _1 == "asdfasdf" }

    refute submission.valid?
  end

  test "#errors_for renders nothing when there are no errors" do
    submission = Submission.new({target: "foobarbaz"})

    render submission.errors_for(:target)

    assert_no_selector "body"
  end

  test "#errors_for renders paragraph with error message when there are errors" do
    submission = Submission.new({target: ""})

    submission.ensures_present(:target)

    render submission.errors_for(:target)

    assert_selector "p", text: "Target must be provided"
  end
end
