# 使用必要的權限連接到 Microsoft Graph
Connect-MgGraph -Scopes "Group.Read.All", "Directory.Read.All", "RoleManagement.Read.Directory"

# 獲取所有已訂閱的 SKU 並建立 SKU ID 和名稱的對應表
$skus = Get-MgSubscribedSku
$skuIdToNameMap = @{ }
foreach ($sku in $skus) {
    $skuIdToNameMap[$sku.SkuId.ToString()] = $sku.SkuPartNumber
}

# 獲取所有使用者，包含所需的屬性
$allUsers = Get-MgUser -All -Property 'UserPrincipalName', 'GivenName', 'DisplayName', 'AssignedLicenses'

# 初始化一個集合來存儲具有 Copilot 授權的使用者資訊
$CopilotLicensesUseList = @()

foreach ($user in $allUsers) {
    # 檢查使用者是否有授權
    if ($user.AssignedLicenses.Count -gt 0) {
        foreach ($license in $user.AssignedLicenses) {
            # 檢查是否為 Copilot 授權
            if ($skuIdToNameMap[$license.SkuId.ToString()] -like "*Copilot*") {
                $CopilotLicensesUseList += [PSCustomObject]@{
                    UserPrincipalName = $user.UserPrincipalName
                    GivenName         = $user.GivenName
                    DisplayName       = $user.DisplayName
                    LicenseName       = $skuIdToNameMap[$license.SkuId.ToString()] # 顯示授權名稱
                }
            }
        }
    }
}

# 假設 $groupDetails 是您要匯出的變數
if ($null -eq $CopilotLicensesUseList) {
    Write-Host "沒有可匯出的資料。"
} else {
    # 確保 csv 資料夾存在
    $csvFolderPath = Join-Path -Path $PSScriptRoot -ChildPath ".csv"
    if (-not (Test-Path -Path $csvFolderPath)) {
        New-Item -ItemType Directory -Path $csvFolderPath
    }

    # 匯出為 CSV 並確認輸出路徑
    $outputPath = Join-Path -Path $csvFolderPath -ChildPath "CopilotLicensesUseList.csv"
    $CopilotLicensesUseList | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

    # 顯示匯出完成訊息
    Write-Host "結果已匯出至 $outputPath"
}

# 斷開與 Microsoft Graph 的連接
Disconnect-MgGraph

# 顯示斷開成功的消息
Write-Host "已成功斷開與 Microsoft Graph 的連接。"
