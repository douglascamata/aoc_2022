def humanize_time_span(span : Time::Span)
  total_milliseconds = span.total_milliseconds
  if total_milliseconds < 1
    return "#{(span.total_milliseconds * 1000).round.to_i} microseconds"
  end

  total_seconds = span.total_seconds
  if total_seconds < 1
    return "#{span.total_milliseconds.round(2)} milliseconds"
  end

  if total_seconds < 60
    return "#{total_seconds.round(2)} seconds"
  end

  minutes = span.minutes
  seconds = span.seconds
  "#{minutes}:#{seconds < 10 ? "0" : ""}#{seconds} minutes"
end
