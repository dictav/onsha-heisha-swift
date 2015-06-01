import Cocoa
import XCPlayground

class Observer: NSObject {
    func hello() {
        NSThread.sleepForTimeInterval(0.3)
        println("Hello, NSThread")
    }
}

let observer = Observer()
let thread = NSThread(target: observer, selector: "hello", object: nil)
thread.start()
println("done")

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)
