class Module;def thread_mattr_reader(*syms,instance_reader:true,instance_accessor:true,default:nil)
syms.each do |sym|raise NameError.new("invalid attribute name: #{sym}") unless /^[_A-Za-z]\w*$/.match?(sym);if default.nil?;class_eval("          def self.#{sym}
            @__thread_mattr_#{sym} ||= \"attr_#{sym}_\#{object_id}\"
            ::ActiveSupport::IsolatedExecutionState[@__thread_mattr_#{sym}]
          end
",__FILE__,__LINE__+1);else default=default.dup.freeze unless default.frozen?;singleton_class.define_method("#{sym}_default_value"){default};class_eval("          def self.#{sym}
            @__thread_mattr_#{sym} ||= \"attr_#{sym}_\#{object_id}\"
            value = ::ActiveSupport::IsolatedExecutionState[@__thread_mattr_#{sym}]

            if value.nil? && !::ActiveSupport::IsolatedExecutionState.key?(@__thread_mattr_#{sym})
              ::ActiveSupport::IsolatedExecutionState[@__thread_mattr_#{sym}] = #{sym}_default_value
            else
              value
            end
          end
",__FILE__,__LINE__+1);end;if instance_reader&&instance_accessor;class_eval("          def #{sym}
            self.class.#{sym}
          end
",__FILE__,__LINE__+1);end;end;end;alias :thread_cattr_reader:thread_mattr_reader;def thread_mattr_writer(*syms,instance_writer:true,instance_accessor:true)
syms.each do |sym|raise NameError.new("invalid attribute name: #{sym}") unless /^[_A-Za-z]\w*$/.match?(sym);class_eval("        def self.#{sym}=(obj)
          @__thread_mattr_#{sym} ||= \"attr_#{sym}_\#{object_id}\"
          ::ActiveSupport::IsolatedExecutionState[@__thread_mattr_#{sym}] = obj
        end
",__FILE__,__LINE__+1);if instance_writer&&instance_accessor;class_eval("          def #{sym}=(obj)
            self.class.#{sym} = obj
          end
",__FILE__,__LINE__+1);end;end;end;alias :thread_cattr_writer:thread_mattr_writer;def thread_mattr_accessor(*syms,instance_reader:true,instance_writer:true,instance_accessor:true,default:nil)thread_mattr_reader(*syms,instance_reader:instance_reader,instance_accessor:instance_accessor,default:default);thread_mattr_writer(*syms,instance_writer:instance_writer,instance_accessor:instance_accessor);end;alias :thread_cattr_accessor:thread_mattr_accessor;end
