module ActionController
module Rescue;extend ActiveSupport::Concern;include ActiveSupport::Rescuable;def show_detailed_exceptions?;false;end;private;def process_action(*)super ;rescue Exception=>exception;request.env["action_dispatch.show_detailed_exceptions"]||=show_detailed_exceptions?;rescue_with_handler(exception)||raise;end;end;end
