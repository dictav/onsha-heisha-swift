//: Playground - noun: a place where people can play

import Foundation
var info = UnsafeMutablePointer<Void>.alloc(sizeof(Void))
let context = CFSocketContext(version: 0, info: info, retain: nil, release: nil, copyDescription: nil)

func didAcceptStream((CFSocket!, CFSocketCallBackType, CFData!, UnsafePointer<Void>, UnsafeMutablePointer<Void>) -> Void) {
    
}

let sockert = CFSocketCreate(kCFAllocatorDefault, PF_INET, SOCK_STREAM, IPPROTO_TCP, kCFSocketAutomaticallyReenableAcceptCallBack, CFSocketCallBack(didAcceptStream), context)

