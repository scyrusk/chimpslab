require 'spec_helper'

describe Publication do
  before(:each) do
    @spiderman = Person.create({
      :name => "Peter Parker",
      :alias => "spiderman",
      :email => "spiderman@marvel.com",
      :url => "http://marvel.com/spiderman/",
      :position => "Ph.D. Student",
      :description => "Bitten by radioactive spider. Climbs walls."
    })
    
    @professorx = Person.create({
      :name => "Charles Xavier",
      :alias => "professorx",
      :url => "http://marvel.com/professorx/",
      :position => "Faculty",
      :description => "Bald head makes reading minds easier."
    })
    
    @france = Venue.create({
      :name => "France"
    })
    
    @valid_attributes = {
      :kind => "Book",
      :authors => "Albert Camus",
      :title => "The Stranger",
      :venue_name => "France",
      :year => "1942"
    }
  end

  it "should create a new instance given valid attributes" do
    Publication.create!(@valid_attributes)
  end
  
  it "should be invalid without a kind" do
    @valid_attributes.delete(:kind)
    pub = Publication.new(@valid_attributes)
    pub.should_not be_valid
  end
  
  it "should be invalid without authors" do
    @valid_attributes.delete(:authors)
    pub = Publication.new(@valid_attributes)
    pub.should_not be_valid
  end
  
  it "should be invalid without a title" do
    @valid_attributes.delete(:title)
    pub = Publication.new(@valid_attributes)
    pub.should_not be_valid
  end
  
  it "should be invalid without a venue name" do
    @valid_attributes.delete(:venue_name)
    pub = Publication.new(@valid_attributes)
    pub.should_not be_valid
  end
  
  it "should be invalid without a year" do
    @valid_attributes.delete(:year)
    pub = Publication.new(@valid_attributes)
    pub.should_not be_valid
  end
  
  it "should be invalid with a non-numerical year" do
    @valid_attributes[:year] = "this year"
    pub = Publication.new(@valid_attributes)
    pub.should_not be_valid
  end
  
  it "should have a list of authors" do
    pub = Publication.new(@valid_attributes)
    pub.authors_list.should have(1).things
    
    pub.authors = "Albert Camus\nAnother Author"
    pub.authors_list.should have(2).things
  end
  
  it "should have the correct number of authors even if some of the lines are blank" do
    @valid_attributes.merge!({
      :authors => "Albert Camus\nAnother Author\n\n\n"
    })
    pub = Publication.new(@valid_attributes)
    pub.authors_list.should have(2).things
  end
  
  ####################################
  # has_and_belongs_to_many :people
  ####################################
  
  it "should have and belongs to many people" do
    @valid_attributes.merge!({
      :authors => "Albert Camus\nPeter Parker"
    })
    pub = Publication.create!(@valid_attributes)
    pub.people.should have(1).things
  end
  
  it "should have and belongs to many people that are authors" do
    @valid_attributes.merge!({
      :authors => "Albert Camus\nPeter Parker\nCharles Xavier"
    })
    pub = Publication.create!(@valid_attributes)
    pub.people.should have(2).things
  end
  
  it "should change number of people that are authors when authors change" do
    @valid_attributes.merge!({
      :authors => "Albert Camus\nPeter Parker\nCharles Xavier"
    })
    pub = Publication.create!(@valid_attributes)
    pub.people.should have(2).things
    
    pub.authors = "Albert Camus\nPeter Parker"
    pub.save!
    pub.people.should have(1).things
  end
  
  #####################
  # belongs_to :venue
  #####################
  
  it "should create a venue when the venue name doesn't exist yet" do
    @valid_attributes.merge!(:venue_name => "Other than France")
    pub = Publication.create!(@valid_attributes)
    
    venues = Venue.find :all
    venues.should have(2).things
  end
  
  it "should belong to a venue" do
    pub = Publication.create!(@valid_attributes)
    pub.venue.should == @france
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

