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

class Publication < ActiveRecord::Base
  KINDS = [
    "Book", "Book Chapter", "Full Paper", "Workshop Paper", 
    "Journal Article", "Work in Progress", "Ph.D. Thesis", 
    "Master's Thesis"
  ].sort
  
  validates_presence_of :kind
  validates_presence_of :authors
  validates_presence_of :title
  validates_presence_of :venue_name
  validates_presence_of :year
  validates_numericality_of :year
  
  has_and_belongs_to_many :people
  
  belongs_to :venue, :counter_cache => true
  
  # Paperclip
  has_attached_file :pdf
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
  
  # Returns an array of the list of author names.
  def authors_list
    self.authors.split("\n").delete_if { |a| a.blank? }.map { |a| a.strip }
  end
  
  # Humanized Attributes
  # http://henrik.nyh.se/2007/12/change-displayed-column-name-in-rails-validation-messages
  HUMANIZED_ATTRIBUTES = {
    :venue_name => "Venue"
  }

  def self.human_attribute_name(attr)
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
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

