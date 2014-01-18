module SearchHelper

  def thread_context_url(post)
    page = (post.order - 1) / 20 + 1
    "<a href=\"http://talk.oaklog.com/index.php?view=#{post.tid}&page=#{page}\">Go</a>"
  end

end
