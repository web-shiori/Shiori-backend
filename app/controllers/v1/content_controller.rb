class V1::ContentController < V1::ApplicationController
  before_action :authenticate_v1_user!
  before_action :correct_user, only: [:update, :destroy]
  skip_before_action :verify_authenticity_token

  def index
    @content = current_v1_user.content.order('created_at DESC')
                      .where('LOWER(title) LIKE ?', "%#{params[:q]}%")
                      .page(params[:page])
                      .per(params[:per_page])
    @content = @content.where(liked: true) if params[:liked]

    @meta = {
      q: params[:q],
      liked: params[:liked],
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

  def create
    @content = current_v1_user.content.build(content_params)
    if @content.save
      render status: :created, json: { data: @content }
    else
      render status: :bad_request, json: { "message": 'content creation faild' }
    end
  end

  def update
    if @content.update(content_params)
      render json: { data: @content }
    else
      render status: :bad_request, json: { "message": 'content updation faild' }
    end
  end

  def destroy
    @content.destroy
    head :no_content
  end

  private def correct_user
    @content = current_v1_user.content.find_by(id: params[:id])
    render status: :forbidden, json: { "message": 'fobidden' } if @content.nil?
  end

  private def content_params
    params.permit(
      :title,
      :url,
      :scroll_position_x,
      :scroll_position_y,
      :max_scroll_position_x,
      :max_scroll_position_y,
      :video_playback_position,
      :specified_text,
      :specified_dom_class,
      :specified_dom_id,
      :specified_dom_tag
    )
  end
end
