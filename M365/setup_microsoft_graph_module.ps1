# 檢查 Microsoft Graph 模組是否已安裝
if (-not (Get-InstalledModule -Name Microsoft.Graph -ErrorAction SilentlyContinue)) {
    # 如果未安裝，則安裝 Microsoft Graph 模組
    Write-Host "Microsoft Graph 模組未安裝，正在安裝..."
    Install-Module -Name Microsoft.Graph -Scope CurrentUser -Force
    Write-Host "Microsoft Graph 模組已成功安裝。"
} else {
    Write-Host "Microsoft Graph 模組已安裝。"
}
