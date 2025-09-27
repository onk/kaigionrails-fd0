require"action_dispatch/journey/visitors";module ActionDispatch;module Journey
class Ast
attr_reader:names,:path_params,:tree,:wildcard_options,:terminals;alias :root:tree;def initialize(tree,formatted)@tree=tree;@path_params=[];@names=[];@symbols=[];@stars=[];@terminals=[];@wildcard_options={};visit_tree(formatted);end;def requirements=(requirements)(symbols+stars).each do |node|re=requirements[node.to_sym];node.regexp=re if re;end;end;def route=(route)terminals.each{|n|n.memo=route};end;def glob?;stars.any?;end;private;attr_reader:symbols,:stars;def visit_tree(formatted)tree.each do |node|if node.symbol?;path_params<<node.to_sym;names<<node.name;symbols<<node;elsif node.star?;stars<<node;if formatted!=false;wildcard_options[node.name.to_sym]||=/.+?/m;end;end;if node.terminal?;terminals<<node;end;end;end;end;module Nodes
class Node
include Enumerable;attr_accessor:left,:memo;def initialize(left)@left=left;@memo=nil;end;def each(&block)Visitors::Each::INSTANCE.accept(self,block);end;def to_s;Visitors::String::INSTANCE.accept(self,"");end;def to_dot;Visitors::Dot::INSTANCE.accept(self);end;def to_sym;name.to_sym;end;def name;-left.tr("*:","");end;def type;raise NotImplementedError;end;def symbol?;false;end;def literal?;false;end;def terminal?;false;end;def star?;false;end;def cat?;false;end;def group?;false;end;end;class Terminal<Node
alias :symbol:left;def terminal?;true;end;end;class Literal<Terminal
def literal?;true;end;def type;:LITERAL;end;end;class Dummy<Literal
def initialize(x=Object.new)super ;end;def literal?;false;end;end;class Slash<Terminal
def type;:SLASH;end;end;class Dot<Terminal
def type;:DOT;end;end;class Symbol<Terminal
attr_accessor:regexp;alias :symbol:regexp;attr_reader:name;DEFAULT_EXP=/[^.\/?]+/;GREEDY_EXP=/(.+)/;def initialize(left,regexp=DEFAULT_EXP)super(left);@regexp=regexp;@name=-left.tr("*:","");end;def type;:SYMBOL;end;def symbol?;true;end;end;class Unary<Node
def children;[left]end;end;class Group<Unary
def type;:GROUP;end;def group?;true;end;end;class Star<Unary
attr_accessor:regexp;def initialize(left)super(left);@regexp=/.+?/m;end;def star?;true;end;def type;:STAR;end;def name;left.name.tr"*:","";end;end;class Binary<Node
attr_accessor:right;def initialize(left,right)super(left);@right=right;end;def children;[left,right]end;end;class Cat<Binary
def cat?;true;end;def type;:CAT;end;end;class Or<Node
attr_reader:children;def initialize(children)@children=children;end;def type;:OR;end;end;end;end;end
