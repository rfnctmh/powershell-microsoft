# 檢查 Microsoft Graph 模組是否已安裝
if (-not (Get-InstalledModule -Name Microsoft.Graph -ErrorAction SilentlyContinue)) {
    # 如果未安裝，則安裝 Microsoft Graph 模組
    Write-Host "Microsoft Graph 模組未安裝，正在安裝..."
    Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
    Write-Host "Microsoft Graph 模組已成功安裝。"
} else {
    Write-Host "Microsoft Graph 模組已安裝。"
}

# 檢查 ImportExcel 模組是否已安裝
if (-not (Get-InstalledModule -Name ImportExcel -ErrorAction SilentlyContinue)) {
    # 如果未安裝，則安裝 ImportExcel 模組
    Write-Host "ImportExcel 模組未安裝，正在安裝..."
    Install-Module -Name ImportExcel -Scope CurrentUser -Force
    Write-Host "ImportExcel 模組已成功安裝。"
} else {
    Write-Host "ImportExcel 模組已安裝。"
}