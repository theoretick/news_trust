require "redis"

class Page
  def self.find_or_create_by(url:, uuid:)
    Redis.current.sadd("pages:#{url}:viewers", uuid)
    find_by(url: url)
  end

  def self.flag_or_create_by(url:, uuid:)
    Redis.current.sadd("pages:#{url}:flaggers", uuid)
    find_by(url: url)
  end

  def self.find_by(url:)
    view_count = Redis.current.scard("pages:#{url}:viewers")
    flag_count = Redis.current.scard("pages:#{url}:flaggers")

    confidence_rating = (((view_count - flag_count) / (view_count == 0 ? 1 : view_count).to_f) * 100).to_i

    rating =
      case confidence_rating
      when 90..100
        "A"
      when 80..90
        "B"
      when 70..80
        "C"
      when 60..70
        "D"
      else
        "F"
      end

    {
      rating: rating,
      view_count: view_count,
      flag_count: flag_count
    }
  end
end
