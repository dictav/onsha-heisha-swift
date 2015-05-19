//: Playground - noun: a place where people can play

import Cocoa
import XCPlayground

let path = XCPSharedDataDirectoryPath.stringByAppendingPathComponent("loltube.png")
println(path)
let image = NSImage(contentsOfFile: path)