import Cocoa
import XCPlayground

public func makeWindow(view: NSView) -> NSWindow {
    // Window size
    
    var window = NSWindow(contentRect: NSRect(x: 600, y: 600, width: 400, height: 100), styleMask: NSTitledWindowMask, backing: .Buffered, defer: false)
    
    // Configure window here
    
    // configure your content view and add subviews here
    window.contentView.addSubview(view)
    window.makeKeyAndOrderFront(nil)
    window.level = 7
    
    return window
}