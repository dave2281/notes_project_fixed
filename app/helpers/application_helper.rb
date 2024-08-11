module ApplicationHelper
  def tags_fixer(note)
    final_tags = []
    tags = note.tags_array
    tags.each do |tag|
      final_tags << (tag.include?('#') ? tag : '#' + tag)
    end
    final_tags.join(' ')
  end
end
