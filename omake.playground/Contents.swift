//: Playground - noun: a place where people can play
//: Swift - UnsafePointerと上手に付き合う dankogai@Qiita
//: http://qiita.com/dankogai/items/2d19b8352183cca3461f

import Foundation

var info = host_basic_info()
var count = mach_msg_type_number_t( sizeof(host_basic_info) / sizeof(integer_t))
var err = withUnsafePointer(&info) {
    host_info(mach_host_self(), HOST_BASIC_INFO, host_info_t($0), &count)
}

info.max_cpus
info

extension host_basic_info {
    func hello() {
        println("hello, host_basic_info")
    }
}

info.hello()