class String;def strip_heredoc;gsub(/^#{scan(/^[ \t]*(?=\S)/).min}/,"").tap do |stripped|stripped.freeze if frozen?;end;end;end
