class ApplicationService
  # def self.call(...) = new.call(...)
  def self.call(*, &) = new(*, &).call
end
