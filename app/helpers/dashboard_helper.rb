module DashboardHelper
  def work_unit_sum_and_count_for(date)
    date = date.to_time.utc
    bucket = WorkUnit.for_user(current_user).scheduled_between(date, date + 1.day)

    count, sum = bucket.count, bucket.sum(:hours)
  end
end
