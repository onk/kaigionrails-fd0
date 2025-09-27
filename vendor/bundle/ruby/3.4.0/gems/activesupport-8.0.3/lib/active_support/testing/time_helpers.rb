require"active_support/core_ext/module/redefine_method";require"active_support/core_ext/time/calculations";module ActiveSupport;module Testing;class SimpleStubs
Stub=Struct.new(:object,:method_name,:original_method);def initialize;@stubs=Hash.new{|h,k|h[k]={}};end;def stub_object(object,method_name,&block)if stub=stubbing(object,method_name);unstub_object(stub);end;new_name="__simple_stub__#{method_name}__#{object_id}";@stubs[object.object_id][method_name]=Stub.new(object,method_name,new_name);object.singleton_class.alias_method new_name,method_name;object.define_singleton_method(method_name,&block);end;def unstub_all!;@stubs.each_value do |object_stubs|object_stubs.each_value do |stub|unstub_object(stub);end;end;@stubs.clear;end;def stubbing(object,method_name)@stubs[object.object_id][method_name];end;def stubbed?;!@stubs.empty?;end;private;def unstub_object(stub)singleton_class=stub.object.singleton_class;singleton_class.silence_redefinition_of_method stub.method_name;singleton_class.alias_method stub.method_name,stub.original_method;singleton_class.undef_method stub.original_method;end;end;module TimeHelpers;def after_teardown;travel_back;super ;end;def travel(duration,with_usec:false,&block)travel_to Time.now+duration,with_usec:with_usec,&block;end;def travel_to(date_or_time,with_usec:false)if block_given?&&in_block;travel_to_nested_block_call="
      Calling `travel_to` with a block, when we have previously already made a call to `travel_to`, can lead to confusing time stubbing.

      Instead of:

         travel_to 2.days.from_now do
           # 2 days from today
           travel_to 3.days.from_now do
             # 5 days from today
           end
         end

      preferred way to achieve above is:

         travel 2.days do
           # 2 days from today
         end

         travel 5.days do
           # 5 days from today
         end

";raise travel_to_nested_block_call;end;if date_or_time.is_a?(Date)&&!date_or_time.is_a?(DateTime);now=date_or_time.midnight.to_time;elsif date_or_time.is_a?(String);now=Time.zone.parse(date_or_time);else now=date_or_time;now=now.to_time unless now.is_a?(Time);end;now=now.change(usec:0) unless with_usec;now=now.getlocal;stubs=simple_stubs;stubbed_time=Time.now if stubs.stubbing(Time,:now);stubs.stub_object(Time,:now){at(now)};stubs.stub_object(Time,:new) do |*args,**options|if args.empty?&&options.empty?;at(now);else stub=stubs.stubbing(Time,:new);Time.send(stub.original_method,*args,**options);end;end;stubs.stub_object(Date,:today){jd(now.to_date.jd)};stubs.stub_object(DateTime,:now){jd(now.to_date.jd,now.hour,now.min,now.sec,Rational(now.utc_offset,86400))};if block_given?;begin self.in_block=true;yield ;ensure if stubbed_time;travel_to stubbed_time;else travel_back;end;self.in_block=false;end;end;end;def travel_back;stubbed_time=Time.current if block_given?&&simple_stubs.stubbed?;simple_stubs.unstub_all!;yield if block_given?;ensure travel_to stubbed_time if stubbed_time;end;alias_method:unfreeze_time,:travel_back;def freeze_time(with_usec:false,&block)travel_to Time.now,with_usec:with_usec,&block;end;private;def simple_stubs;@simple_stubs||=SimpleStubs.new;end;attr_accessor:in_block;end;end;end
