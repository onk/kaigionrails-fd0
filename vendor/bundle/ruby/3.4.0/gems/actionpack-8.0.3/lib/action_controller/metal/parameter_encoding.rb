module ActionController;module ParameterEncoding;extend ActiveSupport::Concern;module ClassMethods;def inherited(klass)
super ;klass.setup_param_encode;end;def setup_param_encode
@_parameter_encodings=Hash.new{|h,k|h[k]={}};end;def action_encoding_template(action)
if @_parameter_encodings.has_key?(action.to_s);@_parameter_encodings[action.to_s];end;end;def skip_parameter_encoding(action)@_parameter_encodings[action.to_s]=Hash.new{Encoding::ASCII_8BIT};end;def param_encoding(action,param,encoding)@_parameter_encodings[action.to_s][param.to_s]=encoding;end;end;end;end
