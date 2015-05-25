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




## 視覚化してみる

NSSlider/NSColor をそれぞれ視覚化してみる

> お題
> NSColor を使ってカラーパレットを作る



## View と連携してみる


