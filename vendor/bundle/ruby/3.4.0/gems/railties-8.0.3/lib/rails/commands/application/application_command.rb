require"rails/generators";require"rails/generators/rails/app/app_generator";module Rails;module Generators;class AppGenerator
def self.exit_on_failure?;true;end;end;end;module Command;class ApplicationCommand<Base
hide_command!;self.bin="rails";def help;perform
end;def perform(*args)Rails::Generators::AppGenerator.start Rails::Generators::ARGVScrubber.new(args).prepare!;end;end;end;end
