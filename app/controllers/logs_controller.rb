class LogsController < ApplicationController
	def index
		@logs = params[:date].present? ? Log.where(created_at: params[:date]).order(created_at: :desc).group_by{|i| i.created_at.to_date} : Log.all.order(created_at: :desc).group_by{|i| i.created_at.to_date}
  end

  def by_date
  	@logs = Log.where(created_at: params[:date])
  end
end
