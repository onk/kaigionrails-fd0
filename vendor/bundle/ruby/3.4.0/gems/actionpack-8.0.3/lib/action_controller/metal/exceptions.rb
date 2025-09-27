module ActionController;class ActionControllerError<StandardError
end;class BadRequest<ActionControllerError
def initialize(msg=nil)super(msg);set_backtrace$!.backtrace if $!;end;end;class RenderError<ActionControllerError
end;class RoutingError<ActionControllerError
attr_reader:failures;def initialize(message,failures=[])super(message);@failures=failures;end;end;class UrlGenerationError<ActionControllerError
attr_reader:routes,:route_name,:method_name;def initialize(message,routes=nil,route_name=nil,method_name=nil)@routes=routes;@route_name=route_name;@method_name=method_name;super(message);end;if defined?(DidYouMean::Correctable)&&defined?(DidYouMean::SpellChecker);include DidYouMean::Correctable;def corrections;@corrections||=begin maybe_these=routes&.named_routes&.helper_names&.grep(/#{route_name}/)||[];maybe_these-=[method_name.to_s]
DidYouMean::SpellChecker.new(dictionary:maybe_these).correct(route_name);end;end;end;end;class MethodNotAllowed<ActionControllerError
def initialize(*allowed_methods)super("Only #{allowed_methods.to_sentence} requests are allowed.");end;end;class NotImplemented<MethodNotAllowed
end;class MissingFile<ActionControllerError
end;class SessionOverflowError<ActionControllerError
DEFAULT_MESSAGE="Your session data is larger than the data column in which it is to be stored. You must increase the size of your data column if you intend to store large data.";def initialize(message=nil)super(message||DEFAULT_MESSAGE);end;end;class UnknownHttpMethod<ActionControllerError
end;class UnknownFormat<ActionControllerError
end;class RespondToMismatchError<ActionControllerError;DEFAULT_MESSAGE="respond_to was called multiple times and matched with conflicting formats in this action. Please note that you may only call respond_to and match on a single format per action.";def initialize(message=nil)super(message||DEFAULT_MESSAGE);end;end;class MissingExactTemplate<UnknownFormat
attr_reader:controller,:action_name;def initialize(message,controller,action_name)@controller=controller;@action_name=action_name;super(message);end;end;end
