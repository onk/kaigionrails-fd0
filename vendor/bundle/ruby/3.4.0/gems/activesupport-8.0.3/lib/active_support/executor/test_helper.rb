module ActiveSupport::Executor::TestHelper
def run(...)Rails.application.executor.perform{super };end;end
