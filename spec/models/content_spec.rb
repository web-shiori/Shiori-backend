require 'rails_helper'

RSpec.describe Content, type: :model do
  before do
    @user = User.new(email: "email@example.com")
    @content = @user.content.new(
      url: "url",
      title: "title"
    )
  end

  describe "set_content_type" do
    it 'pdfのときcontent_typeがpdfになること' do
      @content.pdf = Rack::Test::UploadedFile.new(File.join(Rails.root, 'app/assets/images/sample.png'))
      expect(@content.send(:set_content_type)).to eq "pdf"
    end

    it '動画のときcontent_typeがvideoになること' do
      @content.video_playback_position = 100
      expect(@content.send(:set_content_type)).to eq "video"
    end

    it '音声のときcontent_typeがaudioになること' do
      @content.audio_playback_position = 100
      expect(@content.send(:set_content_type)).to eq "audio"
    end

    it 'その他のときcontent_typeがwebになること' do
      expect(@content.send(:set_content_type)).to eq "web"
    end
  end
end
