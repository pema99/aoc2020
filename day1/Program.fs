open System.IO

let input =
  File.ReadAllLines "input.txt"
  |> Seq.map int
  |> Seq.toList

let perms = seq {
  for i in input do
    for j in input do
      for k in input do
        yield (i, j, k)
}

let satisfy pred seq =
  Seq.pick (fun x -> if pred x then Some x else None) seq

perms 
|> satisfy (fun (i, j, _) -> i + j = 2020)
|> fun (i, j, _) -> i * j
|> printfn "%A"

perms 
|> satisfy (fun (i, j, k) -> i + j + k = 2020)
|> fun (i, j, k) -> i * j * k
|> printfn "%A"