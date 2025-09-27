module ActionDispatch;module Journey
module NFA
module Dot
def to_dot;edges=transitions.map{|from,sym,to|"  #{from} -> #{to} [label=\"#{sym||'ε'}\"];"};"digraph nfa {
  rankdir=LR;
  node [shape = doublecircle];
  #{accepting_states.join' '};
  node [shape = circle];
#{edges.join"\n"}
}
";end;end;end;end;end
