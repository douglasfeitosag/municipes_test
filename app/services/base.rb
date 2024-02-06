class Services::Base
  def call
    raise NotImplementedError
  end
end