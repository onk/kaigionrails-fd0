class Object;def instance_values;instance_variables.to_h do |ivar|[ivar[1..-1].freeze,instance_variable_get(ivar)];end;end;def instance_variable_names;instance_variables.map(&:name);end;end
