require 'test_helper'

class VenueTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: venues
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  publications_count :integer         default(0)
#  created_at         :datetime
#  updated_at         :datetime
#

