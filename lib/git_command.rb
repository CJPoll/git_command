def command command, &block
	temp_args = ARGV.dup
	first = temp_args.shift

	args = []
	options = {}

	is_option = false
	option = ""

	param = false
	temp_args.each do |arg|
		if is_option
			options[option.to_sym] = arg
			is_option = false
		elsif option?(arg)
			is_option = true
			option = arg.gsub /--/, ''
		elsif flag?(arg)
			options[arg] = true
		else
			args << arg
		end
	end

	args = [ nil ] if args == []

	if first == command.to_s
		block.call *args, **options
	end
end

private
def option?( option )
	option.match /\A--/
end

def flag?( flag )
	flag.match /\A-/
end
