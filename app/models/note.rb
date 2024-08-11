class Note < ApplicationRecord
  belongs_to :user
  before_save :tags_array

  validates :title, presence: true, length: { maximum: 100 }
  validates :text, presence: true, length: { maximum: 5000 }
  validates :tags, presence: true, length: { maximum: 255 }, allow_blank: true
  validates :color, inclusion: {in: %w[black red blue green]}

  def tags_array
    if tags.include?('#')
      tags.split('#').map(&:strip).reject(&:empty?)
    else
      tags.split(' ').map(&:strip).reject(&:empty?)
    end
  end
end
