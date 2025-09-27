module ActionController
module PermissionsPolicy;extend ActiveSupport::Concern;module ClassMethods;def permissions_policy(**options,&block)before_action(options) do if block_given?;policy=request.permissions_policy.clone;instance_exec(policy,&block);request.permissions_policy=policy;end;end;end;end;end;end
