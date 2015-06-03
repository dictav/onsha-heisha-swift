# おんしゃへいしゃべんきょうかい３にちめ

非同期処理と通信をやります

## 非同期処理

* NSThread
* NSOperationQueue
* Grand Central Dispatch

参考: https://developer.apple.com/jp/documentation/ConcurrencyProgrammingGuide.pdf

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

GCD は自分で thread を生成しません。処理を Queue に追加するだけで GCD が必要なだけ thread を生成し次々に処理を実行してくれます。

```
import Foundation
import XCPlayground

let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
dispatch_async(queue, {
    println("Hello, GCD")
})

// thread の終了を待つため
XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)
```

### まとめ

非同期を実現したいだけであれば NSOperationQueue を使うのが簡単だと思います。ただ、GCD を直接扱うことでより効率の良いプログラミングを書いたり、シリアルに処理を実行するキューを定義したりできるので、複雑なことをするには GCD を使うのが良いと思います。
スレッド管理に長けて入れば NSThread や pthread を直接使うのも良いと思います。

## 通信

Cocoa には主に以下のような通信手段があります。

* NSURLConnection 
  * Delegate を使ったきめ細かい通信
  * クラスメソッドを使ったざっくり通信 
* NSURLSession を使ったちょうど良い通信
* NSStream を使ったがっつり通信

### NSURLConnection

Delegate を使うとプログレスバーの実装などきめ細かいプログラミングが可能です。
今回はシンプルに通信を行うところだけに紹介します。

#### 同期通信

NSURLConnection は同期通信・非同期通信両方のメソッドが定義されています。

まず同期通信は以下。

```
import Foundation

let request = NSURLRequest(URL: NSURL(string: "http://www.google.com")!)
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
    exit(0)
}

println(res)
println(err)
```

次に非同期通信。これは iOS5 から利用可能になりました。

```
import Foudation
import XCPlayground

let request = NSURLRequest(URL: NSURL(string: "http://www.google.com")!)
NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) {
    (res, data, err) -> Void in
    
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

    println(res)
    println(err)
}

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)
```

非同期通信を行うメソッドを書いているとどこかで同期をとりたくなることがあるので、同期通信で処理は書いておいて NSOperationQueue で非同期にする方が使い勝手が良いことが多いです。

### NSURLSession

iOS7 から現れた新生に NSURLSession というのがあります。こちらはセッション情報もまとめて管理してくれる優れもので、HTTP(S) 専用です。

```
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
```

NSURLSessionTask を作って動作させる形です。
NSOperationQueue を意識しなくてもプログラムが組めることと `suspend` と `resume` を使うことで NSURLConnection ではかなり面倒だったダウンロードの一時停止などを行うことができます。
Taskには以下のものが用意されています。

* NSURLSessionDataTask
* NSURLSessionUploadTask
* NSURLSessionDownloadTask

### NSStream

NSStream は CFStream という C の実装をラッピングしたクラスです。

## お題

Echo サーバーを作って外部から Call しよう
