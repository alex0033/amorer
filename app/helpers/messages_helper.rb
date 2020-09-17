module MessagesHelper
  def add_background(bool)
    unless bool
      "not-read"
    end
  end
end
