module PublicationsHelper
  def link_to_authors(authors_list, people)
    authors_list.map { |author|
      person = nil
      people.each do |p|
        if author == p.name.strip
          person = p
          break
        end
      end
      person ? link_to(author, person) : author
    }.to_sentence
  end
end
