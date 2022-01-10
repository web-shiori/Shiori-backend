class ChangeVideoAudioPlaybackPosition < ActiveRecord::Migration[5.2]
  def change
    change_column :content, :video_playback_position, :integer, default: 0
    change_column :content, :audio_playback_position, :integer, default: 0
  end
end
