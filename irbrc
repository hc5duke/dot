# Require RubyGems by default.
require 'rubygems'

# Activate auto-completion.
require 'irb/completion'

# Use the simple prompt if possible.
IRB.conf[:PROMPT_MODE] = :SIMPLE if IRB.conf[:PROMPT_MODE] == :DEFAULT

# Activate Hirb for formatted ActiveRecord collections/objects
#require 'hirb'
#extend Hirb::Console

# Setup permanent history.
HISTFILE = "~/.irb_history"
MAXHISTSIZE = 10000
begin
  histfile = File::expand_path(HISTFILE)
  if File::exists?(histfile)
    lines = IO::readlines(histfile).collect { |line| line.chomp }
    puts "Read #{lines.nitems} saved history commands from '#{histfile}'." if $VERBOSE
    Readline::HISTORY.push(*lines)
  else
    puts "History file '#{histfile}' was empty or non-existant." if $VERBOSE
  end
  Kernel::at_exit do
    lines = Readline::HISTORY.to_a.reverse.uniq.reverse
    lines = lines[-MAXHISTSIZE, MAXHISTSIZE] if lines.length > MAXHISTSIZE
    puts "Saving #{lines.length} history lines to '#{histfile}'." if $VERBOSE
    File::open(histfile, File::WRONLY|File::CREAT|File::TRUNC) { |io| io.puts lines.join("\n") }
  end
rescue => e
  puts "Error when configuring permanent history: #{e}" if $VERBOSE
end

#
# Random Variables/Functions
#
def install_gems_from_file(filename)
  file = File.open(filename, 'r')
  file.each_line do |line|
    next if line.match /^#/
    gem, version = line.gsub(/(\(|\))/, '').split
    system("gem install #{gem} -v #{version} --no-ri --no-rdoc")
  end and file.close
end
