class ComposerCommand < Vagrant::Command::Base
  def execute
    ARGV.shift()
    puts `vagrant ssh -c "cd /var/vagrant; composer #{ARGV.join(" ")}"`
  end
end

Vagrant.commands.register(:composer) { ComposerCommand }
