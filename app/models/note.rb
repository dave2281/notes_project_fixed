class Note < ApplicationRecord
  belongs_to :user
  before_save :tags_array

  def tags_array
    if tags.include?('#')
      tags.split('#').map(&:strip).reject(&:empty?)
    else
      tags.split(' ').map(&:strip).reject(&:empty?)
    end
  end
end
