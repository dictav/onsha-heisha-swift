おンしゃへいしゃふつかめ
=======================

**Playground は version 5.0(Xcode6.3) 以降で仕様が大きく変わりました**

Playground と戯れる

How to
------

### 基本操作

#### Assistant Editor

右クリックから `Open in Assistant Editor` を選択するか、メニューから `View > Assistant Editor > Open Assistant Editor` を選択すると開くことができます。これは画面分割のような機能で、同時に複数のファイルを見ることができます。ファイルは上部バーにあるパンくずリストにようなメニューから選択することができます。

Playground では `Timeline` を選択することで　`println` などの出力を見ることができます。

#### キーボードアクション

* Cmd+クリック: 実装にジャンプできます
* Option+クリック: マニュアルを見ることができます

#### 実行

Playground ではコードを書くと自動的に実行されますが、同じコードを何度も実行したい時などはメニューから `Editor > Excecute Playground` を選択します。

### 課題をやってみる

前回ざっくりと Swift を思い出してもらったので、実際にコードを書いてみましょう。

> お題
> Swift を使ってフィボナッチ数列を解く関数 `func fib(n: UInt) -> UInt` を実装する

### 計測してみる

末尾再起にすると効率が良くなるなど言われますが、実際に計測しないと信用できません。計測してみます。

> お題
> 作った関数を計測してみる

```
// https://gist.github.com/norio-nomura/399310ba93b730685888
import Foundation
import QuartzCore

func benchmark<T>(block: () -> T) -> String {
    let measure = {(begin: CFTimeInterval) -> CFTimeInterval in block(); return CACurrentMediaTime() - begin}
    let result = String(format: "Total Runtime: %g sec", measure(CACurrentMediaTime()))
    println(result)
    return result
}

func benchmark(block: () -> ()) -> String {
    let measure = {(begin: CFTimeInterval) -> CFTimeInterval in block(); return CACurrentMediaTime() - begin}
    let result = String(format: "Total Runtime: %g sec", measure(CACurrentMediaTime()))
    println(result)
    return result
}
```

これをつかって次ように計測します

```
benchmark {
  fib(10)
}
```

### 数値の変化をグラフにしてみる

Playground には計算結果をグラフ化する機能が標準であります。


Resources を表示してみる
-----------------------

Playground には Resouces というディレクトリが存在します。
ここには画像など Playground と関係するファイルを格納できます。

### NSImage(named:)

`NSImage(named:)` にファイル名を渡すことで簡単に画像を表示できます。

### NSBundle

`NSBundle.mainBundle().pathForImageResource` 次のコードでファイルへのパスを取得することができます。
これで得られたパスを `NSImage(contentsOfFile:)` を渡すことで画像を表示することができます。

### XCPSharedDataDirectoryPath

Playground は sandbox 化された環境で動作しており、外部のファイルにアクセスすることはできません。
ただ、１つだけ例外が用意されており、`XCPSharedDataDirectoryPath` にはアクセスすることができます。
これは一般的には `/Users/username/Documents/Shared Playground Data` というディレクトリになります。この共有ディレクトリにファイルを置けばアクセスできます。

```
let path = XCPSharedDataDirectoryPath.stringByAppendingPathComponent("loltube.png")
```

#### 転ばぬ先の杖、環境変数にアクセスする

`XCPSharedDataDirectoryPath` はサンドボックスな中にあり、実態はシンボリックリンクです。このシンボリックリンクが実際にどこを指しているか、というのは次のように環境変数にアクセスすることで調べることができます。

```
let env = NSProcessInfo.processInfo().environment
println(env["PLAYGROUND_SHARED_DATA_FOLDER"])
```


文書化してみる
-------------


### Playground の構成

Playground は一見すると普通のファイルですが、アプリと同じでパッケージ化されています。中身はこんな感じ

```
_ Hoge.playground
|\_ contents.xcplayground
||_ Contents.swift
||_ Sources
|  \_ SupportCode.swift
|
 \_ Resources
```

ここで playground の実態となるのは `contents.xcplayground` であり、中身は以下のようになります。

```
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<playground version='5.0' target-platform='osx'/>
```

**以前は複数ファイルを扱うやり方がありましたが。最新ではまだみつけてません**

### コメントを書く

[仕様はこちら](https://developer.apple.com/library/ios/documentation/Swift/Reference/Playground_Ref/Chapters/MarkupReference.html#//apple_ref/doc/uid/TP40014789-CH3-SW14)

```
//: 1行コメント
```

```
/*: 複数行コメント
*/
```

このように書くと markdown によく似た書式で文章を書くことができます。
また合わせて覚えて置きたいのは、通常のソースコードでも有効である次の記述です。

```
/// １行コメント
```

```
/** 複数行コメント
:param: name: 引数の説明

:returns: 返り値
*/
```

このように書くとIDEが理解でき参照しやすくなります。

視覚化してみる
-------------

Playground の視覚化には３つの手法があります。それぞれ簡単な例を示して表示してみます。

### 標準のコンポーネント

* NSSlider
* NSColor
* NSBezierPath: `BezierPolygon(UInt) -> NSBezierPath` という関数を用意しました

をそれぞれ視覚化してみる。

#### お題

NSColor を使ってカラーパレットを作る

### XCPCaptureValue

`XCPCaptureValue` を使うことで Timeline にグラフを表示することができます

### XCPShowView

自分の作成した View を Timeline に表示することもできます

### debugQuickLookObject

NSSlider や NSColor などが独自のビューを表示するのは `debugQuickLookObject` メソッドが定義されているからです。これを実装すれば自分の作成したClassに同じように描画機能を持たせることができます。

### NSWindow

さて、ここまでは「Playground の中にいかにして結果を表示するか」ということに注力してやってきました。
「ユーザからのレスポンスを受け取って表示したい」のような要件にはこれまでの方法ではできませんので、自力で Window を作って表示してみます。

次のようなコードで Window を作成することができます。

```
public func makeWindow(view: NSView) -> NSWindow {
    // Window size
    
    var window = NSWindow(contentRect: NSRect(x: 600, y: 600, width: 400, height: 100), styleMask: NSTitledWindowMask, backing: .Buffered, defer: false)
    
    // Configure window here
    
    // configure your content view and add subviews here
    window.contentView.addSubview(view)
    window.makeKeyAndOrderFront(nil)
    window.level = 7
    
    return window
}
```

CIFilter で遊ぶ
--------------

Core Image Filter Reference
https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html

を参考に画像にフィルターをかけてみる

## 参考URL

* https://itunes.apple.com/us/book/playground-secrets-power-tips/id982838034
* https://github.com/erica/swiftslowly/tree/master/Playground%20Secrets%20and%20Power%20Tips
* https://developer.apple.com/swift/blog/downloads/Balloons.zip
* https://github.com/danielpi/Swift-Playgrounds/tree/master/Swift-Playgrounds
