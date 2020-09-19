# isucon10-isuumo

## 環境

- GCE custom（vCPU x 1、メモリ 2 GB）3台
- GCE e2-medium（vCPU x 2、メモリ 4 GB）1台 ベンチマーカー

```
isucon@isu10q:~$ ./bench.sh 
2020/09/19 15:16:17 bench.go:86: === initialize ===
2020/09/19 15:16:27 bench.go:98: === verify ===
2020/09/19 15:16:28 bench.go:108: === validation ===
2020/09/19 15:16:33 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:16:38 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:16:41 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:16:42 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:16:43 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:16:44 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:16:45 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:16:46 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:16:47 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:16:48 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:16:49 load.go:181: 負荷レベルが上昇しました。
2020/09/19 15:17:28 bench.go:110: 最終的な負荷レベル: 11
{"pass":true,"score":10352,"messages":[],"reason":"OK","language":"go"}
```