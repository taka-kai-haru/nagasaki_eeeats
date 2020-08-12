module PostsHelper

  DEFAULT_SCORE = 3

  def default_score_set
    @post.delicious        = DEFAULT_SCORE
    @post.atmosphere       = DEFAULT_SCORE
    @post.accessibility    = DEFAULT_SCORE
    @post.cost_performance = DEFAULT_SCORE
    @post.assortment       = DEFAULT_SCORE
    @post.service          = DEFAULT_SCORE
  end

  def score_average(delicious,atmosphere,accessibility,cost_performance,assortment,service)
    return  (((delicious.to_f + atmosphere.to_f + accessibility.to_f + cost_performance.to_f + assortment.to_f + service.to_f) / 6).round(1)).to_s
  end

end
