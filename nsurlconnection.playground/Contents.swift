//: Playground - noun: a place where people can play

import Foundation
import XCPlayground

let request = NSURLRequest(URL: NSURL(string: "http://www.google.com")!)
func fetchHTML(request: NSURLRequest) -> String? {
    var res: NSURLResponse?
    var err: NSError?
    let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &res, error: &err)
    
    if let e = err {
        println("error:" + e.description)
        exit(0)
    }
    
    if let r = res as? NSHTTPURLResponse where r.statusCode != 200 {
        println("error response code:" + r.description)
        exit(0)
    }
    
    if  let d   = data,
        let str = NSString(data: d, encoding: NSASCIIStringEncoding)
    {
        println(str)
        return str as String
    }
    
    println(res)
    println(err)
    return nil
}

let ret = fetchHTML(request)
println(ret)

NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (res, data, err) -> Void in
    
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
}

NSOperationQueue().addOperationWithBlock {
    let ret = fetchHTML(request)
    println(ret)
}

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)