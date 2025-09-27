module Kernel;def class_eval(*args,&block)singleton_class.class_eval(*args,&block);end;end
