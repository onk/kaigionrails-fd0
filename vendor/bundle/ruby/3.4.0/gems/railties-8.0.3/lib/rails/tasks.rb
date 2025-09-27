require"rake"; %w(framework log misc tmp yarn zeitwerk).tap{|arr|arr<<"statistics" if Rake.application.current_scope.empty?}.each do |task|load"rails/tasks/#{task}.rake";end
