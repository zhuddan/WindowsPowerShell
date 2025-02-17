
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
        nr "dev:$projectName"
    }
}

Set-Alias -Name build -Value b


# s
# nr serve / nr start 
function s {
    param (
        [Parameter(ValueFromRemainingArguments = $true)]
        [string]$command = "serve",  # 默认要查找的命令（你可以调整为其它命令）
        [string]$fallbackCommand = "start"  # 第二个备用命令
    )
    
    # 检查当前目录是否有 package.json 文件
    if (Test-Path "package.json") {
        # 读取 package.json 文件
        $packageJson = Get-Content -Raw -Path "package.json" | ConvertFrom-Json
        
        # 检查 scripts 字段是否存在
        if ($packageJson.scripts) {
            # 检查命令是否存在于 scripts 中
            $foundCommand = $packageJson.scripts.PSObject.Properties.Name |
                            Where-Object { $_ -match "^$command|^$fallbackCommand" } | 
                            Select-Object -First 1

            # 如果找到命令则执行
            if ($foundCommand) {
                Write-Host "Found command '$foundCommand'. Running 'nr $foundCommand'..."
                nr $foundCommand
            } else {
                Write-Host "No matching command ('serve', 'start', or '$command') found in scripts."
            }
        } else {
            Write-Host "No scripts section found in package.json."
        }
    } else {
        Write-Host "No package.json found in the current directory."
    }
}

# vscode 打开当前目录并且自动下载依赖
function vs {
    # 检查当前目录是否有 package.json 文件
    if (Test-Path "package.json") {
        # 如果有 package.json，执行 ni 安装依赖
        Write-Host "package.json found. Installing dependencies using ni..."
        ni
        # 安装完成后使用 VS Code 打开当前目录
        Write-Host "Opening VS Code..."
        code .
    } else {
        # 如果没有 package.json，直接打开 VS Code
        Write-Host "No package.json found. Opening VS Code..."
        code .
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

# 常用目录
function fork {
    Set-Location D:\project\fork
}

function star {
 Set-Location D:\project\star
}

function temp {
    Set-Location D:\project\temp
}

function workspace {
    Set-Location D:\project\workspace
}

function zhuddan {
    Set-Location D:\project\zhuddan
}

function zd {
    Set-Location %USERPROFILE%
}

# . $PROFILE
function reload {
  . $PROFILE
}
