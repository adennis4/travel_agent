class RecordDecorator < SimpleDelegator

  def record
    __getobj__
  end
end
