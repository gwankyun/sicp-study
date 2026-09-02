#set text(lang: "zh", size: 16pt)
#set math.equation(numbering: "(1)")
#let Fib = math.op("Fib")

已知`Fib(n)`是斐波那契函數，及

$ phi = (1 + sqrt(5)) / 2 $ <def:phi>

$ psi = (1 - sqrt(5)) / 2 $ <def:psi>

一、利用歸納法證明 $ Fib(n) = frac(phi^n - psi^n, sqrt(5)) $ <def:question>

二、證明$Fib(n)$是接近$phi^n / sqrt(5)$的整數。

== 第一問

當$n = 0$時，右邊$frac(((1 + sqrt(5)) / 2)^0 - ((1 - sqrt(5)) / 2)^0, sqrt(5)) = 0$，等於左邊$Fib(0)$。

當$n = 1$時，右邊$(((1 + sqrt(5)) / 2)^1 - ((1 - sqrt(5)) / 2)^1) / sqrt(5) = frac((1 + sqrt(5)) - (1 - sqrt(5)), 2sqrt(5)) = 1$，等於左邊$Fib(1)$。

由 @def:phi 及 @def:psi 不難看出與求根公式$frac(-b plus.minus sqrt(b^2 - 4 a c), 2a) $相似，代入可得原方程

$ x^2 - x - 1 = 0 $

變換

$ x^2 = x + 1 $

由於$phi$和$psi$都是此方程之解，所以

$ phi^2 = phi + 1 $

兩邊乘以$phi^(n - 1)$

$ phi^(n + 1) = phi^n + phi^(n - 1) $

同理

$ psi^(n + 1) = psi^n + psi^(n - 1) $

代入 @def:question，右邊等於
$ frac(phi^(n + 1) - psi^(n + 1), sqrt(5)) &= \
  frac((phi^n + phi^(n - 1)) - (psi^n + psi^(n - 1)), sqrt(5)) &= \
  frac((phi^n - psi^n) + (phi^(n - 1) - psi^(n - 1)), sqrt(5)) &= \
  frac(phi^n - psi^n, sqrt(5)) + frac(phi^(n - 1) - psi^(n - 1), sqrt(5)) &= \
  Fib(n) + Fib(n - 1) &= \
  Fib(n + 1)
$

== 第二問

問題即

$ abs(frac(phi^n - psi^n, sqrt(5)) - frac(phi^n, sqrt(5))) < 1/2 $

化簡得

$ abs(psi^n) < sqrt(5) / 2 $

由於 $abs(psi) < 1$，故$abs(psi^0) = 1$是$abs(psi^n)$的最大值，而$sqrt(5) / 2 approx 1.118$，距離嚴格小於 1/2 的整數即為最近整數，得證。
