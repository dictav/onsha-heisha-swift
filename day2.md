# おンしゃへいしゃふつかめ

Playground と戯れる

## How to

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

## Resources を表示してみる

### NSBundle

### XCPSharedDataDirectoryPath

## 文書化してみる

**version 4.0(5.0?) 以降で仕様が大きく変わりました**

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

## 視覚化してみる

NSSlider/NSColor をそれぞれ視覚化してみる

> お題
> NSColor を使ってカラーパレットを作る

### NSBezierPath

### XCPCaptureValue

### debugQuickLookObject

## View と連携してみる

### XCPShowView


## CIFilter で遊ぶ

## 参考URL

* https://itunes.apple.com/us/book/playground-secrets-power-tips/id982838034
* https://github.com/erica/swiftslowly/tree/master/Playground%20Secrets%20and%20Power%20Tips
* https://developer.apple.com/swift/blog/downloads/Balloons.zip
* https://github.com/danielpi/Swift-Playgrounds/tree/master/Swift-Playgrounds
