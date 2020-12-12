defmodule Main do

	def advance_right(data, n) do
	    Enum.map(data, fn line -> Stream.drop(line, n) end)
	end
	
	def drive_sled(data, y, {dx, dy}) do
	    data = advance_right(data, dx)
	    y = y + dy
	    if y >= length(data) do 0
	    else
    	    line = Enum.at(data, y) |> Enum.take(7)
    	    case line do
    	        [:tree|_] -> 1 + drive_sled(data, y, {dx, dy})
    	        [:nothing|_] -> drive_sled(data, y, {dx, dy})
    	    end
	    end
	end

    def parse_file(path) do
        {:ok, contents} = File.read(path)
        lines = contents |> String.split("\n", trim: true)
        lines 
        |> Enum.map(&String.graphemes/1)
        |> Enum.map(fn line ->
            Enum.map(line, fn c ->
                case c do
                    "#" -> :tree
                    _ -> :nothing
                end
            end)
        end)
    end

    def make_infinite(data) do
        Enum.map(data, fn line ->
            Stream.repeatedly(fn -> line end)
            |> Stream.flat_map(&(&1))
        end)
    end

	def main do
        lines = parse_file("input.txt")
        field = make_infinite(lines)

        # part 1
        drive_sled(field, 0, {3, 1})
        |> IO.inspect

        # part 2
        slopes = [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
        slopes
        |> Enum.map(fn slope -> drive_sled(field, 0, slope) end)
        |> Enum.reduce(1, &*/2)
        |> IO.inspect
	end
	
end

Main.main
