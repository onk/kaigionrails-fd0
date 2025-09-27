require"active_support/string_inquirer";require"active_support/core_ext/object/inclusion";module ActiveSupport;class EnvironmentInquirer<StringInquirer
DEFAULT_ENVIRONMENTS= %w[development test production];LOCAL_ENVIRONMENTS= %w[development test];def initialize(env)raise(ArgumentError,"'local' is a reserved environment name") if env=="local";super(env);DEFAULT_ENVIRONMENTS.each do |default|instance_variable_set:"@#{default}",env==default;end;@local=in?LOCAL_ENVIRONMENTS;end;DEFAULT_ENVIRONMENTS.each do |env|class_eval"def #{env}?
  @#{env}
end
",__FILE__,__LINE__+1;end;def local?;@local;end;end;end
