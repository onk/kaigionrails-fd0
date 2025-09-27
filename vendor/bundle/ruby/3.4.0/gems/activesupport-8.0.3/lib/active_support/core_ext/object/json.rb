require"json";require"bigdecimal";require"ipaddr";require"uri/generic";require"pathname";require"active_support/core_ext/big_decimal/conversions"
require"active_support/core_ext/hash/except";require"active_support/core_ext/hash/slice";require"active_support/core_ext/object/instance_variables";require"time";require"active_support/core_ext/time/conversions";require"active_support/core_ext/date_time/conversions";require"active_support/core_ext/date/conversions";module ActiveSupport;module ToJsonWithActiveSupportEncoder
def to_json(options=nil)if options.is_a?(::JSON::State);super(options);else ActiveSupport::JSON.encode(self,options);end;end;end;end;[Enumerable,Object,Array,FalseClass,Float,Hash,Integer,NilClass,String,TrueClass].reverse_each do |klass|klass.include(ActiveSupport::ToJsonWithActiveSupportEncoder);end;class Module;def as_json(options=nil)
name;end;end;class Object;def as_json(options=nil)
if respond_to?(:to_hash);to_hash.as_json(options);else instance_values.as_json(options);end;end;end;class Data
def as_json(options=nil)to_h.as_json(options);end;end;class Struct
def as_json(options=nil)to_h.as_json(options);end;end;class TrueClass;def as_json(options=nil)
self;end;end;class FalseClass;def as_json(options=nil)
self;end;end;class NilClass;def as_json(options=nil)
self;end;end;class String;def as_json(options=nil)
self;end;end;class Symbol;def as_json(options=nil)
name;end;end;class Numeric;def as_json(options=nil)
self;end;end;class Float;def as_json(options=nil)
finite?? self: nil;end;end;class BigDecimal;def as_json(options=nil)
finite?? to_s: nil;end;end;class Regexp;def as_json(options=nil)
to_s;end;end;module Enumerable;def as_json(options=nil)
to_a.as_json(options);end;end;class IO;def as_json(options=nil)
to_s;end;end;class Range;def as_json(options=nil)
to_s;end;end;class Array;def as_json(options=nil)
if options;options=options.dup.freeze unless options.frozen?;map{|v|v.as_json(options)};else map{|v|v.as_json};end;end;end;class Hash;def as_json(options=nil)
subset=if options;if attrs=options[:only];slice(*Array(attrs));elsif attrs=options[:except];except(*Array(attrs));else self;end;else self;end;result={};if options;options=options.dup.freeze unless options.frozen?;subset.each{|k,v|result[k.to_s]=v.as_json(options)};else subset.each{|k,v|result[k.to_s]=v.as_json};end;result;end;end;class Time;def as_json(options=nil)
if ActiveSupport::JSON::Encoding.use_standard_json_time_format;xmlschema(ActiveSupport::JSON::Encoding.time_precision);else  %(#{strftime("%Y/%m/%d %H:%M:%S")} #{formatted_offset(false)});end;end;end;class Date;def as_json(options=nil)
if ActiveSupport::JSON::Encoding.use_standard_json_time_format;strftime("%Y-%m-%d");else strftime("%Y/%m/%d");end;end;end;class DateTime;def as_json(options=nil)
if ActiveSupport::JSON::Encoding.use_standard_json_time_format;xmlschema(ActiveSupport::JSON::Encoding.time_precision);else strftime("%Y/%m/%d %H:%M:%S %z");end;end;end;class URI::Generic
def as_json(options=nil)to_s;end;end;class Pathname
def as_json(options=nil)to_s;end;end;unless IPAddr.method_defined?(:as_json,false);class IPAddr
def as_json(options=nil)to_s;end;end;end;class Process::Status
def as_json(options=nil){exitstatus:exitstatus,pid:pid};end;end;class Exception;def as_json(options=nil)to_s;end;end
