module ActiveSupport;module Concurrency;module NullLock
extend self;def synchronize;yield ;end;end;end;end
