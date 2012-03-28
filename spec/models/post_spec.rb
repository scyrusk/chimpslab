require 'spec_helper'

describe Post do
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
      :title => "value for title",
      :body => "value for body",
      :published_on => Date.today,
      :author_id => @spiderman.id
    }
  end

  it "should create a new instance given valid attributes" do
    Post.create!(@valid_attributes)
  end
  
  it "should be invalid without a title" do
    @valid_attributes.delete(:title)
    post = Post.new(@valid_attributes)
    post.should_not be_valid
  end
  
  it "should be invalid without a body" do
    @valid_attributes.delete(:body)
    post = Post.new(@valid_attributes)
    post.should_not be_valid
  end
  
  it "should belong to an author" do
    post = Post.create(@valid_attributes)
    post.should respond_to :author
    post.author.class.should be Person
    
    @spiderman.posts.should have(1).things
  end
  
  it "should be invalid without an author" do
    @valid_attributes.delete(:author_id)
    post = Post.new(@valid_attributes)
    post.should_not be_valid
  end
  
  it "should be invalid if the author is invalid" do
    @valid_attributes[:author_id] = 200
    post = Post.new(@valid_attributes)
    post.should_not be_valid
  end
end

# == Schema Information
#
# Table name: posts
#
#  id           :integer         not null, primary key
#  title        :string(255)
#  body         :text
#  published_on :date
#  author_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

