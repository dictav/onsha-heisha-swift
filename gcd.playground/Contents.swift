//: Playground - noun: a place where people can play

import Foundation
import XCPlayground

let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
dispatch_async(queue, {
    println("Hello, GCD")
})

let queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

let group = dispatch_group_create()

dispatch_group_async(group, queue) {
    NSThread.sleepForTimeInterval(0.1)
    println("gourp thread:" + NSThread.currentThread().description)
}

dispatch_group_async(group, queue2) {
    NSThread.sleepForTimeInterval(0.1)
    println("gourp thread:" + NSThread.currentThread().description)
}

dispatch_group_notify(group, queue) {
    println("finished")
}

dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
println("done")
