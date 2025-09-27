module ActiveSupport;module ActionableError;extend Concern;class NonActionable<StandardError;end;included do class_attribute:_actions,default:{};end;def self.actions(error)
case error;when ActionableError,->it{Class===it&&it<ActionableError};error._actions;else {};end;end;def self.dispatch(error,name)
actions(error).fetch(name).call;rescue KeyError;raise NonActionable,"Cannot find action \"#{name}\"";end;module ClassMethods;def action(name,&block)_actions[name]=block;end;end;end;end
