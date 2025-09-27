require"benchmark";return if Benchmark.respond_to?(:ms);class <<Benchmark;def ms(&block)
ActiveSupport.deprecator.warn"`Benchmark.ms` is deprecated and will be removed in Rails 8.1 without replacement.
";ActiveSupport::Benchmark.realtime(:float_millisecond,&block);end;end
