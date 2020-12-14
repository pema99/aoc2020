import scala.io.Source

object Program {
    
    // Part 1
    def can_contain_shiny_golden(bag: String, map: Map[String, List[(Int, String)]]) : Boolean = {
        if (!map.contains(bag)) {
            return false
        }
        if (map(bag).exists(_._2 == "shinygold")) {
            return true
        } else {
            for ((_, next) <- map(bag)) {
                if (can_contain_shiny_golden(next, map)) {
                    return true
                }
            }
            return false
        }
    }
    
    // Part 2
    def count_bags(bag: String, map: Map[String, List[(Int, String)]]) : Int = {
        if (!map.contains(bag)) {
            return 1
        } else {
            return 1 + (for ((num, next) <- map(bag)) yield num * count_bags(next, map)).sum
        }
    }
    
    def parse_line(line: String) : Option[(String, List[(Int, String)])] = {
        val args = line.split(" ")
        if (args(4) == "no") {
            return None
        }
        val num_bags = (args.size - 4) / 4
        return Some((args(0) + args(1) -> (1 to num_bags)
                    .map(i => (args(i*4).toInt, args(i*4+1) + args(i*4+2))).toList))
    }
    
    def make_map(lines: List[String]) : Map[String, List[(Int, String)]] = {
        return (for (line <- lines) yield parse_line(line)).flatten.toMap
    }
  
    def main(args: Array[String]) {
        val map = make_map((for (line <- Source.fromFile("input.txt").getLines) yield line).toList)
        val a = map.filter{ case (k, v) => can_contain_shiny_golden(k, map) }.size
        println(s"$a")
        val b = count_bags("shinygold", map) - 1
        println(s"$b")
    }
}