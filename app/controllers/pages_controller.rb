class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
    @notes = Note.where(:user_id => current_user.id)
  end

  def show_by_tag
    @tags = []
    current_user.&note_ids.each do |note_id|
      @tags << Note.where(note_id)
    end
  end
end
