//: Playground - noun: a place where people can play

import Cocoa

/// https://github.com/erica/swiftslowly/tree/master/Playground%20Secrets%20and%20Power%20Tips
func establishFilter(name : String, image : NSImage) -> CIFilter {
    var filter = CIFilter(name:name)
    filter.setDefaults()
    filter.setValue(CIImage(data:image.TIFFRepresentation), forKey: "inputImage")
    return filter
}


//: https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html
let image = NSImage(named: "loltube.png")!

var filter = establishFilter("CIVibrance", image)
filter.setValue(1.0, forKey: "inputAmount")
filter.outputImage

filter = establishFilter("CIColorMonochrome", image)
filter.outputImage