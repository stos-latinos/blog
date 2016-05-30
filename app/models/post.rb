class Post < ActiveRecord::Base
  belongs_to :user
  has_many :rates, dependent: :destroy

  validates :user, :title, :text, :author_ip, presence: true

  def rating
    self.rate_count > 0 ? (self.rate_sum.to_f / self.rate_count).round(2) : 0
  end

  def update_rating(value)
    increment_with_sql!(:rate_count, 1)
    increment_with_sql!(:rate_sum, value)
  end

  def self.get_top(n)
    where('rate_count > 0').
        select('title, text, avg(cast(rate_sum as float) / case rate_count when 0 then 1 else rate_count end) as rating').
        group(:id).
        order('rating desc').
        limit(n)
  end

  def increment_with_sql!(attribute, by = 1)
    self.class.where(:id => id).update_all("#{self.class.connection.quote_column_name attribute} =
                                              CASE WHEN #{self.class.connection.quote_column_name attribute} IS NULL THEN 0
                                              ELSE #{self.class.connection.quote_column_name attribute} END + #{by.to_i}")
    send "#{attribute}=", self.class.unscoped.where(:id => id).select(attribute).first.send(attribute)
  end
end