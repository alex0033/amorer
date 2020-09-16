class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @messages = current_user.receiving_messages.paginate(page: params[:page])
  end

  def new
    @message = Message.new
    @receiver = User.find(params[:receiver_id])
  end

  def create
    @receiver = User.find(params[:receiver_id])
    @message = Message.new(create_params)
    if @message.save
      flash[:success] = "メッセージを送信しました。"
      redirect_to @message
    else
      render 'messages/new'
    end
  end

  def show
    @message = Message.find(params[:id])
    @sender = @message.sender
    @receiver = @message.receiver
    if @receiver == current_user
      @message.read = true
    end
  end

  private

  def create_params
    if par = params[:message]
      {
        title: par[:title],
        receiver: @receiver,
        sender: current_user,
        content: par[:content],
      }
    end
  end
end
