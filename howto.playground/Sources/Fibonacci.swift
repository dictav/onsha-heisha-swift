import Foundation

public func simpleFib(n: Int) -> Int {
    return n < 2 ? n : simpleFib(n - 1) + simpleFib(n - 2)
}

// http://qiita.com/satoshia/items/d39860e54daada5c0693
public func fix(f: (Int -> Int, Int) -> Int) -> (Int -> Int) {
    var fix_f: (Int -> Int)!
    fix_f = {(n: Int) -> Int in return f(fix_f, n)}
    return fix_f
}