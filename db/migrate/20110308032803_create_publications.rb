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

class CreatePublications < ActiveRecord::Migration
  def self.up
    create_table :publications do |t|
      t.string :kind
      t.text :authors
      t.string :title
      t.references :venue
      t.string :venue_name
      t.integer :year
      t.text :abstract

      t.timestamps
    end
    
    add_index :publications, :kind
    add_index :publications, :title
    add_index :publications, :venue_id
    add_index :publications, :venue_name
    add_index :publications, :year
  end

  def self.down
    remove_index :publications, :kind
    remove_index :publications, :title
    remove_index :publications, :venue_id
    remove_index :publications, :venue_name
    remove_index :publications, :year
    
    drop_table :publications
  end
end
