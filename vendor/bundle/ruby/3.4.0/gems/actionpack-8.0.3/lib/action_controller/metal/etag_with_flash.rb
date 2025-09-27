module ActionController;module EtagWithFlash;extend ActiveSupport::Concern;include ActionController::ConditionalGet;included do etag{flash if request.respond_to?(:flash)&&!flash.empty?};end;end;end
