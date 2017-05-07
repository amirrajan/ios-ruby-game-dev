require 'readline'

command = 'rake device'

ios_io = IO.popen(command, 'w')

puts "#{Process.pid}"

Signal.trap('SIGUSR1') do
  ios_io.puts 'exit'
  sleep 1
  ios_io = IO.popen(command, 'w')
end

while expr = Readline.readline('> ', true)
  ios_io.puts expr
  sleep 0.2
end
