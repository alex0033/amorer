class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = current_user.receiving_messages.paginate(page: params[:page])
  end

  def new
    @message = Message.new
  end

  def create
    @receiver = User.find(params[:receiver_id])
    @message = Message.new(create_params)
    if @message.save
      redirect_to @message
    else
      render 'messages/new'
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  private

  def create_params
    if par = params[:message]
      {
        title: par[:title],
        receiver: @receiver,
        sender: current_user,
        kind: par[:kind],
        content: par[:content]
      }
    end
  end
end
