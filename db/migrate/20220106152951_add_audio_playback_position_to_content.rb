class AddAudioPlaybackPositionToContent < ActiveRecord::Migration[5.2]
  def change
    add_column :content, :audio_playback_position, :float
  end
end
