class V1::ContentController < V1::ApplicationController
  before_action :authenticate_v1_user!
  before_action :verify_update, only: [:update]
  before_action :correct_user, only: [:destroy]
  skip_before_action :verify_authenticity_token

  def index
    @content = current_v1_user.content.order('created_at DESC')
                      .search(params[:q])
                      .page(params[:page])
                      .per(params[:per_page])
    @content = @content.where(liked: true) if params[:liked] == "true"

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
      render status: :bad_request, json: { "message": "error: #{@content.errors.messages}" }
    end
  end

  def update
    if @content.update(update_params)
      render json: { data: @content }
    else
      render status: :bad_request, json: { "message": "error: #{@content.errors.messages}" }
    end
  end

  def destroy
    @content.destroy
    head :no_content
  end

  private def verify_update
    current_v1_user.lambda? ? verify_update_pdf_page_num : correct_user
  end

  private def verify_update_pdf_page_num
    @content = Content.find_by(id: params[:id])
    render status: :forbidden, json: { "message": "invalid content" } if @content.nil? || @content.content_type != "pdf"
  end

  private def correct_user
    @content = current_v1_user.content.find_by(id: params[:id])
    render status: :forbidden, json: { "message": "incorrect user" } if @content.nil?
  end

  private def update_params
    if current_v1_user.lambda?
      pdf_page_num_params
    else
      content_params
    end
  end

  private def content_params
    params.permit(
      :title,
      :url,
      :thumbnail_img_url,
      :scroll_position_x,
      :scroll_position_y,
      :max_scroll_position_x,
      :max_scroll_position_y,
      :video_playback_position,
      :specified_text,
      :specified_dom_class,
      :specified_dom_id,
      :specified_dom_tag,
      :liked,
      :pdf
    )
  end

  private def pdf_page_num_params
    params.permit(:pdf_page_num)
  end
end
