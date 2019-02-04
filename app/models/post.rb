class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
  validate :must_be_clickbait

  def includes_clickbait(phrase)
    clickbait = ["Won't Believe", "Secret", "Top", "Guess"]
    return false if phrase.nil?
    clickbait.each do |p|
      return true if phrase.include?(p)
    end
    return false
  end

  def must_be_clickbait
    errors.add(:title, "Title must be clickbait-y") unless includes_clickbait(title)
  end

end
