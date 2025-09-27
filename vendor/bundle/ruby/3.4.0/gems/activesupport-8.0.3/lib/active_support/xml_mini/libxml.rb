require"libxml";require"active_support/core_ext/object/blank";require"stringio";module ActiveSupport;module XmlMini_LibXML
extend self;def parse(data)if !data.respond_to?(:read);data=StringIO.new(data||"");end;if data.eof?;{};else LibXML::XML::Parser.io(data).parse.to_hash;end;end;end;end;module LibXML
module Conversions
module Document
def to_hash;root.to_hash;end;end;module Node
CONTENT_ROOT="__content__";def to_hash(hash={})node_hash={};case hash[name];when Array then hash[name]<<node_hash;when Hash then hash[name]=[hash[name],node_hash];when nil then hash[name]=node_hash;end;each_child do |c|if c.element?;c.to_hash(node_hash);elsif c.text?||c.cdata?;node_hash[CONTENT_ROOT]||=+"";node_hash[CONTENT_ROOT]<<c.content;end;end;if node_hash.length>1&&node_hash[CONTENT_ROOT].blank?;node_hash.delete(CONTENT_ROOT);end;each_attr{|a|node_hash[a.name]=a.value};hash;end;end;end;end;LibXML::XML::Document.include(LibXML::Conversions::Document);LibXML::XML::Node.include(LibXML::Conversions::Node)
