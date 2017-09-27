class ApplicationController < ActionController::Base
  include ActionView::Layouts
  include AbstractController::Helpers

  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  def set_limit_params(klass)
    @limit = params[:per_page] ? params[:per_page].to_i : klass.default_per_page
    @page = params[:page] ? params[:page].to_i : 1
    @offset = @page == 1 ? @page * @limit : nil
  end
end
