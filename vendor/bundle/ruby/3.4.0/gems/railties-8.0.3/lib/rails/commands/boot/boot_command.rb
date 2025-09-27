require"rails/command/environment_argument";module Rails;module Command;class BootCommand<Base
include EnvironmentArgument;desc"boot","Boot the application and exit";def perform(*)=boot_application!;end;end;end
