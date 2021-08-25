class V1::FolderController < V1::ApplicationController
  before_action :authenticate_v1_user!

  def index
    @folders = Folder.all
    @folders = @folders.map do |folder|
      {
        folder_id: folder.id,
        name: folder.name,
        content_count: folder.content.length
      }
    end
    render json: {
      data: {
        folder: @folders
      }
    }
  end


end
