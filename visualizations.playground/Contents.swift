//: Playground - noun: a place where people can play

import Cocoa

//: Color

NSColor(red: 1, green: 0, blue: 0, alpha: 1)

//: Slider

let slider = NSSlider(frame: NSMakeRect(0, 0, 200, 20))

slider.floatValue = 0.5

slider.floatValue = 1.0

//: BezierPath 
BezierPolygon(10)


//: XCPCaptureValue
import XCPlayground

for n in 1...100 {
    if n % 2 == 0 {
       XCPCaptureValue("even", n)
    }
    else {
       XCPCaptureValue("odd", n)
    }
}


//: XCPShowView
let view = NSImageView(frame: NSMakeRect(0, 0, 100, 100))
view.image = NSImage(named: "loltube.png")
XCPShowView("red view", view)

//: debugQuickLookObject
//:
//: NSObject を継承する必要があります。
class Polygon: NSObject {
    func debugQuickLookObject() -> AnyObject? {
        return BezierPolygon(5)
    }
}
Polygon()


//: NSWindow


let sc = SliderController()
sc.handler = { value in
    XCPCaptureValue("slider", value)
}
//let window = makeWindow(sc.slider)
//
//XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)