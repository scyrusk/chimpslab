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

class Person < ActiveRecord::Base
  POSITIONS = [
    "Faculty",
    "Program Assistant",
    "Postdoctoral Researcher",
    "Ph.D. Student",
    "Master's Student",
    "Undergraduate Student",
    "Visiting Researcher",
    "Research Staff",
    "Administrative Staff",
    "Staff",
    "Alumni"
  ]
  
  has_many :posts, :foreign_key => "author_id"
  has_and_belongs_to_many :publications, :order => "year DESC"
  
  # Paperclip attachment
  has_attached_file :avatar,
    :styles => {
      :thumb  => "100x100#",
      :small  => "200x200#",
      :medium => "400x400#"
    },
    :default_url => "/images/v1/no_avatar_92x92.png"
  
  # Pretty URLs
  def to_param
    self.alias
  end
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  validates_length_of :name, :maximum => 100
  
  validates_presence_of :alias
  validates_length_of :alias, :within => 3..15
  validates_uniqueness_of :alias, :case_sensitive => false
  validates_format_of :alias, :with => /\A[\w_]+\z/, :message => "must only have letters, numbers, and underscores."
  
  validates_presence_of :position
  
  # After Save
  after_save :assign_publications
  
  private
    
    def assign_publications
      publications = Publication.find :all
      
      person_name = self.name.strip
      
      publications.each do |publication|
        publication.authors_list.each do |author_name|
          if author_name.strip == person_name and not publication.people.find_by_name(person_name)
            publication.people << self
          end
        end
      end
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
#  emaildisplay        :string(255)
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

