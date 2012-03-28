require 'spec_helper'

describe Venue do
  before(:each) do
    @valid_attributes = {
      :name => "France"
    }
  end

  it "should create a new instance given valid attributes" do
    Venue.create!(@valid_attributes)
  end
  
  it "should update the publications_count when creating a publication" do
    @publication = Publication.create({
      :kind => "Book",
      :authors => "Albert Camus",
      :title => "The Stranger",
      :venue_name => "France",
      :year => "1942"
    })
    
    venue = Venue.find_by_name("France")
    
    expect {
      @publication = Publication.create({
        :kind => "Book",
        :authors => "Albert Camus",
        :title => "The Stranger",
        :venue_name => "France",
        :year => "1942"
      })
      
      # Since we created a publication,
      # we need to reload the venue.
      venue.reload
    }.to change(venue, :publications_count).by(1)
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

