module ActionController;module Logging;extend ActiveSupport::Concern;module ClassMethods;def log_at(level,**options)around_action->(_,action){logger.log_at(level,&action)},**options;end;end;end;end
