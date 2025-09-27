require"active_support/core_ext/module/redefine_method";require"active_support/class_attribute";class Class;def class_attribute(*attrs,instance_accessor:true,instance_reader:instance_accessor,instance_writer:instance_accessor,instance_predicate:true,default:nil)class_methods,methods=[],[];attrs.each do |name|unless name.is_a?(Symbol)||name.is_a?(String);raise TypeError,"#{name.inspect} is not a symbol nor a string";end;name=name.to_sym;namespaced_name=:"__class_attr_#{name}";::ActiveSupport::ClassAttribute.redefine(self,name,namespaced_name,default);delegators=["def #{name}; #{namespaced_name}; end","def #{name}=(value); self.#{namespaced_name} = value; end",];class_methods.concat(delegators);if singleton_class?;methods.concat(delegators);else methods<<"silence_redefinition_of_method def #{name}
  if defined?(@#{name})
    @#{name}
  else
    self.class.#{name}
  end
end
" if instance_reader;end;methods<<"silence_redefinition_of_method(:#{name}=)
attr_writer :#{name}
" if instance_writer;if instance_predicate;class_methods<<"silence_redefinition_of_method def #{name}?; !!self.#{name}; end";if instance_reader;methods<<"silence_redefinition_of_method def #{name}?; !!self.#{name}; end";end;end;end;location=caller_locations(1,1).first;class_eval(["class << self",*class_methods,"end",*methods].join(";").tr("\n",";"),location.path,location.lineno);end;end
