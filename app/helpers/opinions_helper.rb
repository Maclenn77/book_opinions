# This module helps to show the Opinions in the view
module OpinionsHelper
  def worldcat_link(opinion)
    t = opinion.modify_title
    "https://www.worldcat.org/search?q=#{t}"
  end

  def user_edit(opinion)
    return nil unless current_user == opinion.user

    link_to('create', edit_opinion_path(opinion),
            class: 'material-icons', method: :get)
  end

  def user_destroy(opinion)
    return nil unless current_user == opinion.user

    link_to('delete', user_opinion_path(opinion.user, opinion),
            class: 'material-icons', method: :delete,
            data: { confirm: 'Are you sure?' })
  end
end
