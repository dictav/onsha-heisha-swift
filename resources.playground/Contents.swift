//: Playground - noun: a place where people can play

import Cocoa
import XCPlayground

//: 画像を表示してみる

NSImage(named: "loltube.png")
NSImage(contentsOfFile: "/path/to/loltube.png")

//: NSBundle

let imagePath = NSBundle.mainBundle().pathForImageResource("loltube.png")!
NSImage(contentsOfFile: imagePath)



//: XCPSharedDataDirectoryPath
let dir = XCPSharedDataDirectoryPath
println(dir)
let sharePath = dir.stringByAppendingPathComponent("loltube.png")
NSImage(contentsOfFile: sharePath)

//: NSSearchPath
let list = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
let sharePath2 = list.first!
    .stringByAppendingPathComponent("Shared Playground Data")
    .stringByAppendingPathComponent("loltube.png")
println(sharePath2)
NSImage(contentsOfFile: sharePath2)


//: 環境変数にアクセスしてみる

let info = NSProcessInfo.processInfo()
let env = info.environment
println(env["PLAYGROUND_SHARED_DATA_FOLDER"])



