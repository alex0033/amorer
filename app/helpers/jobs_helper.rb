module JobsHelper
  def show_reward(job)
    amount = show_amount(job.reward_min_amount, job.reward_max_amount)
    case job.reward_type
    when 1
      "時給：#{amount}"
    when 2
      "日給：#{amount}"
    when 3
      "成果報酬：#{amount}"
    when 4
      REWARD_MESSAGE
    end
  end

  def show_amount(min, max)
    if min.nil? && max.nil?
      REWARD_MESSAGE
    elsif min.nil? || max.nil? || min == max
      "#{min || max}円"
    else
      "#{min}円〜#{max}円"
    end
  end
end
