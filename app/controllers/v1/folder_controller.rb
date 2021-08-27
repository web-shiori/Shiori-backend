class V1::FolderController < V1::ApplicationController
  before_action :authenticate_v1_user!
  before_action :correct_user, only: [:update, :destroy, :content_list, :add_content_to_folder, :remove_content_to_folder]
  before_action :correct_user_for_content_folder, only: [:add_content_to_folder, :remove_content_to_folder]

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
      render status: :bad_request, json: { "message": "error: #{@folder.errors.messages}" }
    end
  end

  def update
    if @folder.update(folder_params)
      render json: { data: @folder }
    else
      render status: :bad_request, json: { "message": "error: #{@folder.errors.messages}" }
    end
  end

  def destroy
    @folder.destroy
    head :no_content
  end

  # Q: ↓のメソッドは独自にコントローラーを作るべきなのか？わからない
  # 指定したfolder内のコンテンツ一覧を返す
  def content_list
    @content = @folder.content.order('created_at DESC')
                      .where('LOWER(title) LIKE ?', "%#{params[:q]}%")
                      .page(params[:page])
                      .per(params[:per_page])
    @meta = {
      q: params[:q],
      page: params[:page],
      per_page: params[:per_page],
      netxPage: @content.next_page
    }
    render json: {
      meta: @meta,
      data: {
        content: @content
      }
    }
  end

  # コンテンツをフォルダに追加する
  def add_content_to_folder
    @content_folder = ContentFolder.new(content_id: @content.id, folder_id: @folder.id)
    if @content_folder.save
      head :created
    else
      render status: :bad_request, json: { "message": 'adding content to folder faild' }
    end
  end

  # フォルダからコンテンツを削除する
  def remove_content_to_folder
    @content_folder = ContentFolder.find_by(content_id: @content.id, folder_id: @folder.id)
    @content_folder.destroy
    head :no_content
  end

  private def correct_user
    @folder = current_v1_user.folder.find_by(id: params[:id])
    render status: :forbidden, json: { "message": 'fobidden' } if @folder.nil?
  end

  private def correct_user_for_content_folder
    @content = current_v1_user.content.find_by(id: params[:content_id])
    render status: :forbidden, json: { "message": 'fobidden' } if @content.nil?
  end

  private def folder_params
    params.permit(:name)
  end
end
