# おんしゃへいしゃべんきょうかい３にちめ

非同期処理と通信をやります

## 非同期処理

* NSThread
* NSOperationQueue
* Grand Central Dispatch

### NSThread

NSThread は最も基本的な非同期処理の手法です。メッセージ送信を使って任意の処理を行います。

```
import Cocoa
import XCPlayground

class Observer: NSObject {
    func hello() {
        NSThread.sleepForTimeInterval(0.3)
        println("Hello, NSThread")
    }
}

let observer = Observer()
let thread = NSThread(target: observer, selector: "hello", object: nil)
thread.start()
println("done")

// thread の終了を待つため
XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)
```

ここで注意したいのは、 この `target` と `selector` によるオブジェクトのメッセージ送信は Swift では推奨されておらず、類似の多くのメソッドが実装されていません。
例えば `-[NSObject peformSelectorInBackground:withObject:]` などは UIKit で非同期処理を行う時によく使われましたが Swift にはありません。

### NSOperationQueue

NSThread は扱いが難しく、いろいろ問題を引き起こすということで、iOS4 のころから導入された非同期処理のためのクラスが NSOperationQueue です。

iOS4 以前にも NSOperation を使った非同期処理は可能でしたが、NSOperation を継承したクラスを実装する必要があり、ちょっとしたことをするにはあまり一般的ではありませんでした。これを比較的簡単にしたのが NSOperationQueue と Block という新文法でした。

```
import Foundation
import XCPlayground

NSOperationQueue().addOperationWithBlock {
    NSThread.sleepForTimeInterval(0.3)
    println("Hello, NSOperationQueue")
}

// thread の終了を待つため
XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)
```

### Grand Central Dispatch

NSOperationQueue と同時に導入されたのが GCD (Grand Central Dispatch) です。NSOperation/NSOperationQueue のベースはGCDです。

GCD は自分で thread を生成しません。

## 通信

Cocoa には主に以下のような通信手段があります。

* NSURLConnection 
  * Delegate を使ったきめ細かい通信
  * クラスメソッドを使ったざっくり通信 
* NSURLSession を使ったちょうど良い通信
* NSStream を使ったがっつり通信

### NSStream

NSStream は CFStream という C の実装をラッピングしたクラスです。

## お題

Echo サーバーを作って外部から Call しよう
