module Rails;module Command;class AboutCommand<Base
desc"about","List versions of all Rails frameworks and the environment";def perform;boot_application!;say Rails::Info;end;end;end;end
