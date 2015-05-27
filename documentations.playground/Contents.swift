//: Playground - noun: a place where people can play

import Cocoa

//: https://developer.apple.com/library/ios/documentation/Swift/Reference/Playground_Ref/Chapters/MarkupReference.html#//apple_ref/doc/uid/TP40014789-CH3-SW14
//: これはドキュメント
//:
//: `Editor > Show Rendered Markup`
//:
//: `Editor > Show Raw Markup`

/*:
ブロック化もできる
*/

//: ![](loltube.png)

//: ドキュメント

/// これは hello を表示します
///
/// :param: name: 名前
/// :returns: 名前
func hello(name: String) -> String {
    let msg = "Hello, \(name)!"
    println(msg)
    return msg
}
