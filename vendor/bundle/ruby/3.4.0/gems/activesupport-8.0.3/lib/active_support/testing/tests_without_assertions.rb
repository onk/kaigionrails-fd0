module ActiveSupport;module Testing;module TestsWithoutAssertions
def after_teardown;super ;if assertions.zero?&&!skipped?&&!error?;file,line=method(name).source_location;warn"Test is missing assertions: `#{name}` #{file}:#{line}";end;end;end;end;end
