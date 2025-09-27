require"active_support/execution_wrapper";require"active_support/executor";module ActiveSupport;class Reloader<ExecutionWrapper;define_callbacks:prepare;define_callbacks:class_unload;def self.to_prepare(*args,&block)set_callback(:prepare,*args,&block);end;def self.before_class_unload(*args,&block)set_callback(:class_unload,*args,&block);end;def self.after_class_unload(*args,&block)set_callback(:class_unload,:after,*args,&block);end;to_run(:after){self.class.prepare!};def self.reload!;executor.wrap do new.tap do |instance|instance.run!;ensure instance.complete!;end;end;prepare!;end;def self.run!(reset:false)
if check!;super ;else Null;end;end;def self.wrap(**kwargs)return yield if active?;executor.wrap(**kwargs) do instance=run!;begin yield ;ensure instance.complete!;end;end;end;class_attribute:executor,default:Executor;class_attribute:check,default:lambda{false};def self.check!
@should_reload||=check.call;end;def self.reloaded!
@should_reload=false;end;def self.prepare!
new.run_callbacks(:prepare);end;def initialize;super ;@locked=false;end;def require_unload_lock!;unless @locked;ActiveSupport::Dependencies.interlock.start_unloading;@locked=true;end;end;def release_unload_lock!;if @locked;@locked=false;ActiveSupport::Dependencies.interlock.done_unloading;end;end;def run!
super ;release_unload_lock!;end;def class_unload!(&block)
require_unload_lock!;run_callbacks(:class_unload,&block);end;def complete!
super ;self.class.reloaded!;ensure release_unload_lock!;end;end;end
