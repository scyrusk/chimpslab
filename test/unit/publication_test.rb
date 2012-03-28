require 'test_helper'

class PublicationTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end


# == Schema Information
#
# Table name: publications
#
#  id               :integer         not null, primary key
#  kind             :string(255)
#  authors          :text
#  title            :string(255)
#  venue_id         :integer
#  venue_name       :string(255)
#  year             :integer
#  abstract         :text
#  created_at       :datetime
#  updated_at       :datetime
#  pdf_file_name    :string(255)
#  pdf_content_type :string(255)
#  pdf_file_size    :integer
#  pdf_updated_at   :datetime
#

