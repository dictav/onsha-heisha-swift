//: Playground - noun: a place where people can play

import Foundation
import XCPlayground

NSOperationQueue().addOperationWithBlock {
    NSThread.sleepForTimeInterval(0.3)
    println("Hello, NSOperationQueue")
}

// thread の終了を待つため
XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)
