//: Playground - noun: a place where people can play

import Foundation
import XCPlayground

let request = NSURLRequest(URL: NSURL(string: "http://www.google.com")!)
let session = NSURLSession.sharedSession()
let task = session.dataTaskWithRequest(request, completionHandler: {
    (data, res, err) -> Void in
    
    if let e = err {
        println("error:" + e.description)
        return
    }
    
    if let r = res as? NSHTTPURLResponse where r.statusCode != 200 {
        println("error response code:" + r.description)
        return
    }
    
    if  let d   = data,
        let str = NSString(data: d, encoding: NSASCIIStringEncoding)
    {
        println(str)
    }
})

task.resume()

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)