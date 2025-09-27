class Module;def alias_attribute(new_name,old_name)module_eval"      def #{new_name}; self.#{old_name}; end          # def subject; self.title; end
      def #{new_name}?; self.#{old_name}?; end        # def subject?; self.title?; end
      def #{new_name}=(v); self.#{old_name} = v; end  # def subject=(v); self.title = v; end
",__FILE__,__LINE__+1;end;end
