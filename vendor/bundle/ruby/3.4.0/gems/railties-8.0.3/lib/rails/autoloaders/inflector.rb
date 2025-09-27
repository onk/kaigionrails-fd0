require"active_support/inflector";module Rails;class Autoloaders;module Inflector
@overrides={};def self.camelize(basename,_abspath)@overrides[basename]||basename.camelize;end;def self.inflect(overrides)@overrides.merge!(overrides);end;end;end;end
