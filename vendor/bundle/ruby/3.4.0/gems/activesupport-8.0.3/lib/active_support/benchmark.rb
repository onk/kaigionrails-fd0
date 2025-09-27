module ActiveSupport;module Benchmark
def self.realtime(unit=:float_second,&block)time_start=Process.clock_gettime(Process::CLOCK_MONOTONIC,unit);yield ;Process.clock_gettime(Process::CLOCK_MONOTONIC,unit)-time_start;end;end;end
