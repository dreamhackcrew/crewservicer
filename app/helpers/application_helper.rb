module ApplicationHelper
  def administrator?
    @current_person && @current_person.administrator?
  end

  def distance_of_time_in_hours_and_minutes_to_now(time)
    distance_in_seconds = (time.to_time.to_f - Time.now.to_f).abs

    distance_in_minutes = distance_in_seconds / 60
    hours = (distance_in_minutes / 60).floor
    minutes = (hours > 0 ? (distance_in_minutes % 60) : distance_in_minutes).round

    parts = []
    parts << "#{hours} h" if hours > 0
    parts << "#{minutes} min"

    parts.join(' ')
  end

  def human_relatable_time(time, explicit_today = false)
    date = time.to_date
    case date
    when Date.today
      if explicit_today
        "#{t :'date.today'} #{l time, format: :time}"
      else
        localize(time, format: :time)
      end
    when Date.yesterday
      "#{t :'date.yesterday'} #{l time, format: :time}"
    when Date.tomorrow
      "#{t :'date.tomorrow'} #{l time, format: :time}"
    when (Date.today - 6)..(Date.today + 7)
      localize(time, format: :weekday_time)
    else
      localize(time, format: :short)
    end
  end
end
