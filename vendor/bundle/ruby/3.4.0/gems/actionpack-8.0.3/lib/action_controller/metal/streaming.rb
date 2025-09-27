module ActionController
module Streaming;private;def _render_template(options)if options.delete(:stream);headers["cache-control"]||="no-cache";view_renderer.render_body(view_context,options);else super ;end;end;end;end
