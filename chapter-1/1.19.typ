#set text(lang: "zh", size: 16pt)

$T_(p g)$變換

$ a' <- b q + a q + a p $

$ b' <- b p + a q $

$
 a'' &= b' q + a' q + a' p \
     &= (b p + a q) q + (b q + a q + a p) q + (b q + a q + a p) p \
     &= b p q + a q ^ 2 + b q^2 + a q^2 + a p q + b p q + a p q + a p ^ 2 \
     &= 2 b p q + b q^2 + a p ^ 2 + 2 a q^2 + 2 a p q \
     &= b(2 p q + q^2) + a (2 q^2 + 2 p q + p ^2)
$

$
 b'' &= b' p \
     &= (b p + a q) p \
     &= b p^2 + a b p
$

$T_(p' g')$變換

$p'$和$q'$變換如下：

$ a' &= b q' + a q' + a p' \
     &= b q' + a (q' + p') $

$ b' <- b p' + a q' $

代入

$ q' = 2p q + q^2 $

$ q' + p' &= 2 q^2 + 2 p q + p ^2 \
  (2p q + q^2) + p' &= 2 q^2 + 2 p q + p ^2 \
                 p' &= p^2 + q ^ 2
$
