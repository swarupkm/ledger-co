# frozen_string_literal: true

require './lib/command_session'

def main
  fileinput = ARGV[0]
  file = File.open(fileinput)
  session = CommandSession.new
  file.readlines.each do |line|
    command, *a = line.split(' ')
    session.send command.downcase.to_sym, a
  end
end

main