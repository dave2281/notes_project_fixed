class PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notes, only: [:show_by_tag, :home]
  before_action :set_tags, only: [:show_by_tag, :home]
  before_action :set_notes_by_tag, only: [:show_by_tag]

  def home
  end

  def show_by_tag
  end

  private

  def set_notes
    @notes = Note.where(user_id: current_user.id)
  end

  def set_tags
    @tags = []

    @notes.each do |note|
      note.tags_array.each do |tag|
        @tags << tag unless tag.nil?
      end
    end
  end

  def set_notes_by_tag
    @notes = Note.where(user_id: current_user.id).select { |note| note.tags_array.include?(params[:tag]) }
  end
end
