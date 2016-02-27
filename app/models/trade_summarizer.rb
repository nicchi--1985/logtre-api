class TradeSummarizer
  PRODUCTS = ["Stock", "Future", "Option", "Exchange"]

  # month_period: サマリの単位。月数を指定
  # num_of_periods: サマリ集計数を指定
  # start_date: 集計の起点を指定
  def self.create_summaries(trades:, month_period:, num_of_periods:5, start_date:Date.today)
    periods = create_period_list(month_period, num_of_periods, start_date)
    trade_lists = devide_in_periods(trades, periods, month_period)
    summaries = []
    trade_lists.each_with_index do |trade_list, i|
      summary = summarize(periods[i], trade_list)
      summaries.push(summary)
    end
    return summaries
  end

  def self.create_product_summaries(trades:, month_period:, start_date:Date.today)
    trade_lists = devide_in_products(trades)
    summaries = []
    trade_lists.each_with_index do |trade_list, i|
      summary = summarize(start_date, trade_list, PRODUCTS[i])
      summaries.push(summary)
    end
    return summaries
  end

  private
  def self.devide_in_periods(trades, periods, month_period)
    trade_lists = []
    # todo: impliment!
    # 対象のpriodにtradeが一つもない場合は空arrayをつっこむ
    # ActiveSupport: at_beginning_of_month, end_of_month, months_ago(x)
    # trade_lists: [[trade1,trade2,trade3],[trade4,trade5],[trade6]]
    periods.each do |p|
      list = trades.find_all do |t|
        q_start = p.months_ago(month_period - 1).at_beginning_of_month
        q_end = p.end_of_month
        t.implimentation_date.between?(q_start, q_end)
      end
      trade_lists.push(list)
    end
    return trade_lists
  end

  def self.devide_in_products(trades)
    trade_lists = []
    PRODUCTS.each do |p|
      list = trades.find_all {|t| t.tradable_type == p}
      trade_lists.push(list)
    end
    return trade_lists
  end

  def self.create_period_list(month_period, num_of_periods, start_date)
    list = []
    num_of_periods.times do |i|
      period = start_date.months_ago(i*month_period)
      list.push(period)
    end
    return list
  end

  def self.summarize(period, trade_list, product_type=nil)
    plus_benefit = 0.0
    minus_benefit = 0.0
    trade_list.each do |trade|
      rate = trade.benefit_rate || 0
      if rate >= 0
        plus_benefit += rate
      elsif rate < 0
        minus_benefit += rate
      end
    end
    summary = TradeSummary.new(period, plus_benefit, minus_benefit, product_type)
    return summary
  end
end
