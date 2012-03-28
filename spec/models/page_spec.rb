require 'spec_helper'

describe Page do
  before(:each) do
    @valid_attributes = {
      :title => "Hello There",
      :permalink => "hello-there",
      :body => "Hello There Again!"
    }
  end

  it "should create a new instance given valid attributes" do
    Page.create!(@valid_attributes)
  end
  
  it "should be invalid without a permalink" do
    @valid_attributes.delete(:permalink)
    page = Page.new(@valid_attributes)
    page.should_not be_valid
  end
  
  it "should be invalid when permalink has capital letters" do
    @valid_attributes[:permalink] = "Hello-There"
    page = Page.new(@valid_attributes)
    page.should_not be_valid
  end
  
  it "should be invalid when permalink has spaces" do
    @valid_attributes[:permalink] = "this is spacious"
    page = Page.new(@valid_attributes)
    page.should_not be_valid
  end
  
  it "should be invalid when permalink has invalid characters" do
    @valid_attributes[:permalink] = "hello!"
    page = Page.new(@valid_attributes)
    page.should_not be_valid
  end
  
  it "should be invalid without a body" do
    @valid_attributes.delete(:body)
    page = Page.new(@valid_attributes)
    page.should_not be_valid
  end
end
