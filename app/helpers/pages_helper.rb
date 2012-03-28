module PagesHelper
  def render_page(permalink, options={})
    default_options = {
      :show_title => true
    }.merge(options)
    
    page = permalink.is_a?(Page) ? permalink : Page.find_by_permalink(permalink)
    
    if page
      html = textilize(page.body)
      
      if authorized?
        html += <<-HTML
          <div class="admin_actions">
            <b>Actions:</b>
            #{link_to("Edit", edit_page_path(page))}
          </div>
        HTML
      end
      
      html
    else
      if authorized?
        <<-HTML
          <p>
            <i>#{permalink}</i> doesn't exist.
            #{link_to("Create <i>#{permalink}</i> page.", new_page_path(:permalink => permalink))}
          </p>
        HTML
      else
        ""
      end
    end
  end
end
