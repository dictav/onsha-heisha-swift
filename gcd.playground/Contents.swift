//: Playground - noun: a place where people can play

import Foundation
import XCPlayground

let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
dispatch_async(queue, {
    println("Hello, GCD")
})

// thread の終了を待つため
XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)