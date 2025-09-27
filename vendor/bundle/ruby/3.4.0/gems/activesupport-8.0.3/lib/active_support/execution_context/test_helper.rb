module ActiveSupport::ExecutionContext::TestHelper
def before_setup;ActiveSupport::ExecutionContext.clear;super ;end;def after_teardown;super ;ActiveSupport::ExecutionContext.clear;end;end
