﻿# 檢查 PowerShell 版本
$psVersion = $PSVersionTable.PSVersion

# 設定要卸載的模組名稱
$moduleName = "Microsoft.Graph"

# 檢查 Microsoft Graph 模組是否已安裝
if (Get-InstalledModule -Name $moduleName -ErrorAction SilentlyContinue) {
    # 如果已安裝，則根據 PowerShell 版本決定卸載命令
    Write-Host "$moduleName 模組已安裝，正在卸載..."

    if ($psVersion.Major -ge 5) {
        # 使用 -AllowPrerelease 參數（如果需要）
        try {
            Uninstall-Module -Name $moduleName -AllVersions -AllowPrerelease
            Write-Host "已成功卸載模組 $moduleName，包括所有版本。"
        } catch {
            # 如果出現錯誤，則不使用 AllowPrerelease
            Write-Host "卸載時出現錯誤：$($_.Exception.Message)正在嘗試不使用 AllowPrerelease 卸載..."
            Uninstall-Module -Name $moduleName -AllVersions
            Write-Host "已成功卸載模組 $moduleName（未使用 AllowPrerelease）。"
        }
    } else {
        # 對於較舊的版本，只使用基本的卸載命令
        Uninstall-Module -Name $moduleName -AllVersions
        Write-Host "已成功卸載模組 $moduleName（適用於舊版本 PowerShell）。"
    }
} else {
    Write-Host "$moduleName 模組未安裝。"
}