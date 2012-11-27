require 'log_lady/filter'

module LogLady
  describe Filter do
    describe ".filter" do

      let(:controller) { stub 'controller', { current_user_name: 'Mr. MacGuffin' } }

      it "sets log_lady_user_name thread local variable" do
        username = :not_set
        Filter.filter(controller) do
          username = Thread.current[:log_lady_user_name]
        end
        username.should == "Mr. MacGuffin"
      end

      it "unsets log_lady_user_name after the action" do
        Filter.filter(controller) do end
        Thread.current.key?(:log_lady_user_name).should be_false
      end

      it "unsets log_lady_user_name on error" do
        begin # protect example from actual error
          Filter.filter(controller) do
            raise 'exception'
          end
        rescue; end
        Thread.current.key?(:log_lady_user_name).should be_false
      end

    end
  end
end
