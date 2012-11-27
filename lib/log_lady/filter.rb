module LogLady
  class Filter

    def self.filter(controller)
      Thread.current[:log_lady_user_name] = controller.current_user_name
      yield
    ensure
      Thread.current[:log_lady_user_name] = nil
    end

  end
end
