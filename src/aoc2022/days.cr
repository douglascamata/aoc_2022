require "./days/*"

module Aoc2022
  {% begin %}
    DAYS = {
      {% for day, index in parse_type("Aoc2022").resolve.constants %}
        {% if index != 0 %}
          {{day.stringify[3..].to_i}} => Aoc2022::{{day}},
        {% end %}
      {% end %}
  }
  {% end %}
end
