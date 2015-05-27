import Cocoa

public typealias DidChangeHandler = (Float -> Void)
public class SliderController: NSObject {
    public let slider = NSSlider(frame: NSRect(x: 0, y: 50, width: 400, height: 40))
    public var handler: DidChangeHandler?
    
    public override init() {
        super.init()
        slider.target = self
        slider.action = "changed:"
    }
    
    func changed(s: NSSlider) {
        handler?(s.floatValue)
    }
}