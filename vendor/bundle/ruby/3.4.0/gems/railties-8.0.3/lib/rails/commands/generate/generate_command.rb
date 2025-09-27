require"rails/generators";module Rails;module Command;class GenerateCommand<Base
no_commands do def help;boot_application!;load_generators;Rails::Generators.help self.class.command_name;end;end;def perform(*)generator=args.shift;return help unless generator;boot_application!;load_generators;ARGV.replace(args)
Rails::Generators.invoke generator,args,behavior: :invoke,destination_root:Rails::Command.root;end;end;end;end
