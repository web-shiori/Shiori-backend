class V1::FolderController < V1::ApplicationController
  before_action :authenticate_v1_user!

  def index
    @folder = current_v1_user.folder
    @folder = @folder.map do |folder|
      {
        folder_id: folder.id,
        user_id: folder.user_id,
        name: folder.name,
        content_count: folder.content.length
      }
    end
    render json: {
      data: {
        folder: @folder
      }
    }
  end

  def create
    @folder = current_v1_user.folder.build(folder_params)
    if @folder.save
      render status: :created, json: { data: @folder }
    else
      render status: :bad_request, json: { "message": 'folder creation faild' }
    end
  end

  def update
    @folder = Folder.find(params[:id])
    if @folder.update(folder_params)
      render json: { data: @folder }
    else
      render status: :bad_request, json: { "message": 'folder updation faild' }
    end
  end

  def destroy
    Folder.find(params[:id]).destroy
    head :no_content
  end

  private def folder_params
    params.permit(:name)
  end
end
