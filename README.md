# はじめに

これはWindows Server CoreのDockerコンテナー上でBackgroundServiceを利用したWindowsサービスが正しく起動できない事象の再現リポジトリーです。

# 分かってること

- .NET Frameworkに昔からあるServiceBaseで作ったものは動く
- Generic Hostベースのものが、Dockerコンテナー上のWindows Server CoreコンテナーでWindows Serviceとして動かない（.NET6も.NET Framework 4.7もNG）
- Generic Hostベースであっても、下記の環境では動作する
  - ホストのWindows 10
  - ホストのWindows 11
  - Hyper-V上のWindows Server 2019
  - Hyper-V上のWindows Server 2019 Server Core
- Generic Hostベースのものを、Dockerコンテナー上のWindows Server Coreコンテナーであってもコンソールからなら動く

明らかにDocker上だけ挙動がおかしいです。

# 再現手順

build.ps1を実行すると、下記の処理が事項されます。

1. 各種Windowsサービスプログラムのビルド
  1. .NET 6.0で作られたBackgroundServiceベースのWindowsサービス
  2. .NET Framework 4.7で作られたBackgroundServiceベースのWindowsサービス
  2. .NET Framework 4.7で作られたServiceBaseベースのWindowsサービス
2. Windows Server Coreコンテナーのビルド
3. Windows Server Coreコンテナーの起動

コンテナーが起動し、PowerShellのコンソールが表示されるため、下記を実行してください。

```powershell
Get-Service | ? { $_.Name.StartsWith('Test-') }
```

起動直後はServiceBaseのものはStatusがRunningに表示されますが、BackgroundServiceのものは「StartPre...」と表示され、しばらくするとStoppedに変わります。

C:\bin\BackgroundService-net6.0の下にlog.txtが出力されているので

```powershell
Get-Content .\log.txt
```

のようにログを見てみると、ログ出力はされているのが確認できます。

この処理はBackgroundServiceの起動処理が完了した後に実行されているので、BackgroundServiceの起動処理が正しく完了したことが取れておらず、終了されてしまっていることが見て取れます。

イベントログには特段エラーはでていません。

困ったなぁ。