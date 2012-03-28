# Copyright (c) 2011, Ian Li (http://ianli.com)
#
# The MIT License
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

class Post < ActiveRecord::Base
  belongs_to :author, :class_name => "Person", :foreign_key => "author_id"
  
  named_scope :published, lambda {
    {
      :conditions => ["published_on IS NOT NULL AND DATE(published_on) <= ?", Date.today],
      :order => "published_on DESC"
    }
  }
  
  named_scope :unpublished, lambda {
    {
      :conditions => ["published_on IS NULL OR DATE(published_on) > ?", Date.today],
      :order => "published_on DESC"
    }
  }
  
  def published?
    self.published_on != nil && self.published_on <= Date.today
  end
  
  
  ###############
  # Validations
  ###############
  
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :author_id
  
  def validate
    begin
      # Validate that the author exists.
      person = Person.find(author_id) unless author_id.nil?
    rescue
      errors.add(:author, "doesn't exist.")
    end
  end
  
  ##################################
  # published_on using Chronic
  # for natural language date/time
  ##################################
  
  def chronic_published_on=(str)
    @chronic_published_on = str
    if str.blank?
      self.published_on = nil
    else
      self.published_on = Chronic.parse(str) || Date.parse(str)
    end
  end
  
  def chronic_published_on
    @chronic_published_on || self.published_on
  end
  
  # Humanized Attributes
  # http://henrik.nyh.se/2007/12/change-displayed-column-name-in-rails-validation-messages
  HUMANIZED_ATTRIBUTES = {
    :chronic_published_on => "Published on"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
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

