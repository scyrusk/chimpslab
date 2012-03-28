require 'spec_helper'

describe Person do
  before(:each) do
    @spiderman = Person.create({
      :name => "Peter Parker",
      :alias => "spiderman",
      :email => "spiderman@marvel.com",
      :url => "http://marvel.com/spiderman/",
      :position => "Ph.D. Student",
      :description => "Bitten by radioactive spider. Climbs walls."
    })
    
    @valid_attributes = {
      :name => "Charles Xavier",
      :alias => "professorx",
      :url => "http://marvel.com/professorx/",
      :position => "Faculty",
      :description => "Bald head makes reading minds easier."
    }
  end

  it "should create a new instance given valid attributes" do
    Person.create!(@valid_attributes)
  end
  
  it "should be invalid without a name" do
    @valid_attributes.delete(:name)
    person = Person.new(@valid_attributes)
    person.should_not be_valid
  end
  
  it "should be invalid with a name that is too long" do
    @valid_attributes[:name] = "This name is too long. It has more than 100 characters. Who has a name like that? This person's parents were trying to be too creative."
    person = Person.new(@valid_attributes)
    person.should_not be_valid
  end
  
  it "should be invalid without an alias" do
    @valid_attributes.delete(:alias)
    person = Person.new(@valid_attributes)
    person.should_not be_valid
  end
  
  it "should have alias within 3 and 15 characters" do
    @valid_attributes[:alias] = "p"
    person = Person.new(@valid_attributes)
    person.should_not be_valid
    
    @valid_attributes[:alias] = "morethan15characters"
    person = Person.new(@valid_attributes)
    person.should_not be_valid
    
    @valid_attributes[:alias] = "has space"
    person = Person.new(@valid_attributes)
    person.should_not be_valid
    
    @valid_attributes[:alias] = "invalidchars!"
    person = Person.new(@valid_attributes)
    person.should_not be_valid
  end
  
  it "should have a unique alias" do
    @valid_attributes[:alias] = "spiderman"
    person = Person.new(@valid_attributes)
    person.should_not be_valid
  end
  
  it "should have a unique name" do
    @valid_attributes[:alias] = "Peter Parker"
    person = Person.new(@valid_attributes)
    person.should_not be_valid
  end
  
  it "should be invalid without a position" do
    @valid_attributes.delete(:position)
    person = Person.new(@valid_attributes)
    person.should_not be_valid
  end
  
  #########################################
  # has_and_belongs_to_many :publications
  #########################################
  
  it "should update publications that have authors with the person's name" do
    publication = Publication.create!({
      :kind => "Book",
      :authors => "Albert Camus",
      :title => "The Stranger",
      :venue_name => "France",
      :year => "1942"
    })
    
    expect {
      Person.create!({
        :name => "Albert Camus",
        :alias => "camus",
        :url => "http://existentialists.com/camus/",
        :position => "Writer",
        :description => "I wrote The Stranger."
      })
      publication.reload
    }.to change(publication.people, :count).by(1)
  end
end

# == Schema Information
#
# Table name: people
#
#  id                  :integer         not null, primary key
#  alias               :string(255)
#  name                :string(255)
#  email               :string(255)
#  url                 :string(255)
#  position            :string(255)
#  description         :text
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

