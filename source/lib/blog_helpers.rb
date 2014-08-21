module BlogHelpers
  def article_author
    article_information.author
  end

  def article_tags
    article_information.tags
  end

  def article_date
    format_date(current_article.date)
  end

  def article_information
    current_article.data
  end

  private

  def format_date(date)
    date.strftime('%b %e, %Y')
  end
end
