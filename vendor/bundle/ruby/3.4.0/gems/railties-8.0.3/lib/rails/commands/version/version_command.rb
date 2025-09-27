module Rails;module Command;class VersionCommand<Base
desc"version","Show the Rails version";def perform;Rails::Command.invoke:application,["--version"];end;end;end;end
