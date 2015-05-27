//: Playground - noun: a place where people can play

import Cocoa

//: フィボナッチ数列
var fib = simpleFib

var fib2 = fix {
    (f: Int -> Int, n: Int) -> Int in
    return n < 2 ? n : f(n - 1) + f(n - 2)
}

//: 計測する
benchmark {
    for n in 1...10 {
        fib(n)
    }
}

benchmark {
    for n in 1...10 {
        fib2(n)
    }
}

//: Editor > Execute Playground
