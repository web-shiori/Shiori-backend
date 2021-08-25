class V1::FolderController < V1::ApplicationController
  before_action :authenticate_v1_user!
  before_action :correct_user, only: [:update, :destroy]

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
    if @folder.update(folder_params)
      render json: { data: @folder }
    else
      render status: :bad_request, json: { "message": 'folder updation faild' }
    end
  end

  def destroy
    @folder.destroy
    head :no_content
  end

  # Q: ↓のメソッドは独自にコントローラーを作るべきなのか？わからない
  # 指定したfolder内のコンテンツ一覧を返す
  def content_list
    folder = Folder.find(params[:folder_id])
    @content = folder.content.order('created_at DESC')
                     .where()
  end

  def add_content_to_folder

  end

  def remove_content_to_folder

  end

  private def correct_user
    @folder = current_v1_user.folder.find_by(id: params[:id])
    render status: :forbidden, json: { "message": 'fobidden' } if @folder.nil?
  end

  private def folder_params
    params.permit(:name)
  end
end
