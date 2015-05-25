#! /usr/bin/swift

println("Hello, Swift!")

let 🐶 = "dog"
let 🐱 = "cat"

println(🐶)
println(🐱)

infix operator ✖️  { associativity left }
func ✖️  (x: String, n: Int) -> String {
    var a: String = ""
    for (var i = 0; i < n; i++) {
        a = a + x
    }

    return a
}

println(🐶✖️4)
