module OpinionsHelper
  def worldcat_link(opinion)
    t = opinion.modify_title
    "https://www.worldcat.org/search?q=#{t}"
  end
end
