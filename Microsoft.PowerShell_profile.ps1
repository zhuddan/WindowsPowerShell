
# https://github.com/antfu-collective/ni
if (-not (Test-Path $profile)) {
  New-Item -ItemType File -Path (Split-Path $profile) -Force -Name (Split-Path $profile -Leaf)
}

$profileEntry = 'Remove-Item Alias:ni -Force -ErrorAction Ignore'
$profileContent = Get-Content $profile
if ($profileContent -notcontains $profileEntry) {
  ("`n" + $profileEntry) | Out-File $profile -Append -Force -Encoding UTF8
}
Remove-Item Alias:ni -Force -ErrorAction Ignore


# 别名
# npm run dev
function d {
    param(
        [string]$projectName  # projectName 是可选参数
    )

    # 如果没有提供 projectName 参数，执行 nr dev
    if (-not $projectName) {
        nr dev
    } else {
        # 如果提供了 projectName，执行 nr dev:$projectName
        nr "dev:$projectName"
    }
}

Set-Alias -Name dev -Value d

# npm run watch
function w {
    param(
        [string]$projectName  # projectName 是可选参数
    )

    # 如果没有提供 projectName 参数，执行 nr watch
    if (-not $projectName) {
        nr watch
    } else {
        # 如果提供了 projectName，执行 nr watch:$projectName
        nr "watch:$projectName"
    }
}

Set-Alias -Name watch -Value w

# npm run test
function t {
    param(
        [string]$projectName  # projectName 是可选参数
    )

    # 如果没有提供 projectName 参数，执行 nr test
    if (-not $projectName) {
        nr test
    } else {
        # 如果提供了 projectName，执行 nr test:$projectName
        nr "test:$projectName"
    }
}

Set-Alias -Name test -Value t

# npm run build
function b {
    param(
        [string]$projectName  # projectName 是可选参数
    )

    # 如果没有提供 projectName 参数，执行 nr build
    if (-not $projectName) {
        nr build
    } else {
        # 如果提供了 projectName，执行 nr build:$projectName
        nr "build:$projectName"
    }
}

Set-Alias -Name build -Value b

# s
# nr serve / nr start 
function s {
    param (
        [string]$projectName  # projectName 参数用于确定要执行的命令
    )

    # 检查当前目录是否有 package.json 文件
    if (Test-Path "package.json") {
        # 读取 package.json 文件
        $packageJson = Get-Content -Raw -Path "package.json" | ConvertFrom-Json
        
        # 检查 scripts 字段是否存在
        if ($packageJson.scripts) {
            # 默认命令，如果没有提供 projectName，默认执行 serve 或 start
            $defaultCommand = if (-not $projectName) { "serve" } else { "serve:$projectName" }

            # 先查找 serve 命令
            $foundCommand = $packageJson.scripts.PSObject.Properties.Name |
                            Where-Object { $_ -eq $defaultCommand } |
                            Select-Object -First 1

            # 如果没有找到 serve 命令，尝试查找 start 命令
            if (-not $foundCommand) {
                $foundCommand = $packageJson.scripts.PSObject.Properties.Name |
                                Where-Object { $_ -eq "start" } |
                                Select-Object -First 1
            }

            # 如果没有找到任何命令，检查是否有 serve:xxx 或 start:xxx 命令
            if (-not $foundCommand) {
                $foundCommand = $packageJson.scripts.PSObject.Properties.Name |
                                Where-Object { $_ -eq "serve:$projectName" } |
                                Select-Object -First 1
            }

            if (-not $foundCommand) {
                $foundCommand = $packageJson.scripts.PSObject.Properties.Name |
                                Where-Object { $_ -eq "start:$projectName" } |
                                Select-Object -First 1
            }

            # 如果找到命令，则执行
            if ($foundCommand) {
                Write-Host "Found command '$foundCommand'. Running 'nr $foundCommand'..."
                nr $foundCommand
            } else {
                Write-Host "No matching command ('serve', 'start', or 'serve:$projectName', 'start:$projectName') found in scripts."
            }
        } else {
            Write-Host "No scripts section found in package.json."
        }
    } else {
        Write-Host "No package.json found in the current directory."
    }
}

# 特殊的 npm script 
function tag {
    param(
        [string]$projectName  # projectName 是可选参数
    )

    # 如果没有提供 projectName 参数，执行 nr tag
    if (-not $projectName) {
        nr tag
    } else {
        # 如果提供了 projectName，执行 nr tag:$projectName
        nr "tag:$projectName"
    }
}

# 发布公共包
function pub {
   npm publish --access public
}

# 发布私有包
function pubres {
   npm publish --access restricted
}

Set-Alias -Name serve -Value s

#  http-server
function hs {
    param(
        [string]$path 
    )
    if (-not $path) {
        http-server -c-0 --cors
    } else {
        http-server $path -c-0 --cors
    }
}


# vscode 打开当前目录并且自动下载依赖
function vs {

    # 使用 VS Code 打开当前目录
    Write-Host "Opening VS Code..."
    code .
    
    # 检查当前目录是否有 package.json 文件
    if (Test-Path "package.json") {
        # 如果有 package.json，执行 ni 安装依赖
        Write-Host "package.json found. Installing dependencies using ni..."
        ni

    } else {
        Write-Host "No package.json found."
    }
}

# g: git clone 简化命令
function g {
    param(
        [Parameter(Mandatory=$true)]
        [string]$repoUrl,  # 必填参数，表示要克隆的 Git 仓库 URL

        [string]$dir  # 可选参数，表示克隆到的目录
    )

    # 如果 dir 参数为空，执行 git clone $repoUrl
    if (-not $dir) {
        Write-Host "Cloning repository '$repoUrl'..."
        git clone $repoUrl
    } else {
        # 如果 dir 参数不为空，执行 git clone $repoUrl $dir
        Write-Host "Cloning repository '$repoUrl' into directory '$dir'..."
        git clone $repoUrl $dir
    }
}

# git
function go {
  git remote -v
}

# 清理缓存
function cleanup {
    del .\package-lock.json, .\yarn.lock, .\bun.lockb, .\pnpm-lock.yaml -ErrorAction SilentlyContinue
    Remove-Item -Recurse -Force .\node_modules -ErrorAction SilentlyContinue
}



# 打开当前目录
function o {
    start .
}

# 常用目录
function fork {
    Set-Location D:\projects\fork
}

function star {
    Set-Location D:\projects\star
}

function temp {
    Set-Location D:\projects\temp
}

function workspace {
    Set-Location D:\projects\workspace
}

function zhuddan {
    Set-Location D:\projects\zhuddan
}

function zd {
    Set-Location %USERPROFILE%
}

# # . $PROFILE
# function reload {
#   . $PROFILE
# }

