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

class AddPdfColumnsToPublications < ActiveRecord::Migration
  def self.up
    add_column :publications, :pdf_file_name,    :string
    add_column :publications, :pdf_content_type, :string
    add_column :publications, :pdf_file_size,    :integer
    add_column :publications, :pdf_updated_at,   :datetime
  end

  def self.down
    remove_column :publications, :pdf_file_name
    remove_column :publications, :pdf_content_type
    remove_column :publications, :pdf_file_size
    remove_column :publications, :pdf_updated_at
  end
end