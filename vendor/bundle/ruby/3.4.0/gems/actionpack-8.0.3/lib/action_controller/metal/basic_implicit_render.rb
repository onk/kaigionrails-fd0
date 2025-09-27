module ActionController;module BasicImplicitRender
def send_action(method,*args)ret=super ;default_render unless performed?;ret;end;def default_render;head:no_content;end;end;end
