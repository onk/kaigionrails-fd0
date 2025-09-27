require"active_support/deep_mergeable";class Hash;include ActiveSupport::DeepMergeable;def deep_merge?(other)
other.is_a?(Hash);end;end
