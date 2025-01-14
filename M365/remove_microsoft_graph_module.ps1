# 檢查 PowerShell 版本
$psVersion = $PSVersionTable.PSVersion

# 設定要卸載的模組名稱
$moduleNameGraph = "Microsoft.Graph"
$moduleNameExcel = "ImportExcel"

# 檢查 Microsoft Graph 模組是否已安裝
if (Get-InstalledModule -Name $moduleNameGraph -ErrorAction SilentlyContinue) {
    # 如果已安裝，則根據 PowerShell 版本決定卸載命令
    Write-Host "$moduleNameGraph 模組已安裝，正在卸載..."

    if ($psVersion.Major -ge 5) {
        # 使用 -AllowPrerelease 參數（如果需要）
        try {
            Uninstall-Module -Name $moduleNameGraph -AllVersions -AllowPrerelease
            Write-Host "已成功卸載模組 $moduleNameGraph，包括所有版本。"
        } catch {
            # 如果出現錯誤，則不使用 AllowPrerelease
            Write-Host "卸載時出現錯誤：$($_.Exception.Message)正在嘗試不使用 AllowPrerelease 卸載..."
            Uninstall-Module -Name $moduleNameGraph -AllVersions
            Write-Host "已成功卸載模組 $moduleNameGraph（未使用 AllowPrerelease）。"
        }
    } else {
        # 對於較舊的版本，只使用基本的卸載命令
        Uninstall-Module -Name $moduleNameGraph -AllVersions
        Write-Host "已成功卸載模組 $moduleNameGraph（適用於舊版本 PowerShell）。"
    }
} else {
    Write-Host "$moduleNameGraph 模組未安裝。"
}

# 檢查 ImportExcel 模組是否已安裝
if (Get-InstalledModule -Name $moduleNameExcel -ErrorAction SilentlyContinue) {
    # 如果已安裝，則根據 PowerShell 版本決定卸載命令
    Write-Host "$moduleNameExcel 模組已安裝，正在卸載..."

    if ($psVersion.Major -ge 5) {
        # 使用 -AllowPrerelease 參數（如果需要）
        try {
            Uninstall-Module -Name $moduleNameExcel -AllVersions -AllowPrerelease
            Write-Host "已成功卸載模組 $moduleNameExcel，包括所有版本。"
        } catch {
            # 如果出現錯誤，則不使用 AllowPrerelease
            Write-Host "卸載時出現錯誤：$($_.Exception.Message)正在嘗試不使用 AllowPrerelease 卸載..."
            Uninstall-Module -Name $moduleNameExcel -AllVersions
            Write-Host "已成功卸載模組 $moduleNameExcel（未使用 AllowPrerelease）。"
        }
    } else {
        # 對於較舊的版本，只使用基本的卸載命令
        Uninstall-Module -Name $moduleNameExcel -AllVersions
        Write-Host "已成功卸載模組 $moduleNameExcel（適用於舊版本 PowerShell）。"
    }
} else {
    Write-Host "$moduleNameExcel 模組未安裝。"
}
