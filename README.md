# Microsoft.PowerShell_profile.ps1 配置

## 使用
1. 复制 `Microsoft.PowerShell_profile.ps1`的内容 到 `你的配置文件内` 即可

    使用 `vscode` 打开你的配置
    ```shell
    code $PROFILE
    ```

    或者使用 `txt` 打开
    ```shell
    notepad $PROFILE
    ```

2. 复制[Microsoft.PowerShell_profile.ps1](https://github.com/zhuddan/WindowsPowerShell/blob/master/Microsoft.PowerShell_profile.ps1)内容到你的配置文件中并且保存。


3. 保存之后需要重载你的配置
    ```shell
    . $PROFILE
    ```

然后你就可以愉快玩耍了, 记得重新开口终端窗口。

## 命令/别名

- d/dev
```shell
 d  # nr dev
 d a # nr dev:a
 d b # nr dev:b
 dev  # nr dev
 dev a # nr dev:a
 dev b # nr dev:b
```

- w/watch
```shell
 w  # nr watch
 w a # nr watch:a
 w b # nr watch:b
 watch  # nr watch
 watch a # nr watch:a
 watch b # nr watch:b
```

- w/build
```shell
 b  # nr build
 b a # nr build:a
 b b # nr build:b
 build  # nr build
 build a # nr build:a
 build b # nr build:b
```

- s/server
 
> [!NOTE]  
> `s/server`命令会检查`package.json`的`server` 和 `start`脚本。 并且`server`的优先级更高。由于`start`是内置的命令，故别名为`server`。你可以手动修改`Microsoft.PowerShell_profile.ps1`调整优先级。

如果你的 `package.json` 只有 `start` 脚本
```shell
 s  # nr start
 s a # nr start:a
 s b # nr start:b
 server  # nr start
 server a # nr start:a
 server b # nr start:b
```

如果你的 `package.json` 有 `server` 脚本，此时 `start` 命令会被忽略。
```shell
 s  # nr server
 s a # nr server:a
 s b # nr server:b
 server  # nr server
 server a # nr server:a
 server b # nr server:b
```
- hs 
```shell
 hs # http-server $output -c-0 --cors
 hs dist # http-server dist $output -c-0 --cors # 此时 http-server 入口为 dist
```

- g
``` shell
g https://github.com/microsoft/TypeScript # git clone https://github.com/microsoft/TypeScript
g https://github.com/microsoft/TypeScript ts # git clone https://github.com/microsoft/TypeScript ts
```
- go
```shell
 go # git remote -v
```
- cleanup
```shell
 cleanup # del .\package-lock.json, .\bun.lockb, .\pnpm-lock.yaml -ErrorAction SilentlyContinue
    Remove-Item -Recurse -Force .\node_modules -ErrorAction SilentlyContinue
```

参考
- [ni](https://github.com/antfu-collective/ni)
- [http-server](https://github.com/http-party/http-server)

