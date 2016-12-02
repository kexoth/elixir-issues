defmodule CLITest do
	use ExUnit.Case
	doctest Issues

	import Issues.CLI, only: [parse_args: 1, sort_asc: 1]
	
	test ":help returned by option parsing with -h and --help options" do
		assert parse_args(["-h", "anything"]) == :help
		assert parse_args(["--help", "anything"]) == :help
	end
	
	test "three values returned if three given" do
		assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
	end
	
	test "count is defaulted if two values given" do
		assert parse_args(["user", "project"]) == {"user", "project", 4}
	end
	
	test "sort ascending order the correct way" do
		result = ["2010-05-04", "2222-2-22", "1989-7-15"]
		|> fake_list
		|> sort_asc
		#|> IO.inspect
		
		issues = for issue <- result, do: issue["created_at"]
		assert issues == ["1989-7-15", "2010-05-04", "2222-2-22"]
	end
	
	defp fake_list(values) do
		for value <- values, do: %{"created_at" => value, other_data: :random}
	end
end
