//
// This file (and all other Swift source files in the Sources directory of this playground) will be precompiled into a framework which is automatically made available to howto.playground.
//

import Foundation
import QuartzCore

/// https://gist.github.com/norio-nomura/399310ba93b730685888
public func benchmark(block: () -> ()) -> String {
    let measure = {(begin: CFTimeInterval) -> CFTimeInterval in block(); return CACurrentMediaTime() - begin}
    let result = String(format: "Total Runtime: %g sec", measure(CACurrentMediaTime()))
    println(result)
    return result
}
