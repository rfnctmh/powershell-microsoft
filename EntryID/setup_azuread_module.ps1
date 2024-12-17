# 檢查 AzureAD 模組是否已安裝
if (-not (Get-Module -ListAvailable -Name AzureAD)) {
    # 如果未安裝，則安裝 AzureAD 模組
    Write-Host "AzureAD 模組未安裝，正在安裝..."
    Install-Module -Name AzureAD -Scope CurrentUser -Force
    Write-Host "AzureAD 模組已成功安裝。"
} else {
    Write-Host "AzureAD 模組已安裝。"
}