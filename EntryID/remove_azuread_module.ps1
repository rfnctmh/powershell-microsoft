# 檢查 AzureAD 模組是否已安裝
if (Get-Module -ListAvailable -Name AzureAD) {
    # 如果已安裝，則卸載 AzureAD 模組
    Write-Host "AzureAD 模組已安裝，正在卸載..."
    Uninstall-Module -Name AzureAD -AllVersions -Force
    Write-Host "AzureAD 模組已成功卸載。"
} else {
    Write-Host "AzureAD 模組未安裝。"
}
