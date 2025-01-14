# 連接到 Microsoft Graph
Connect-MgGraph -Scopes "User.ReadWrite.All", "Organization.Read.All"

# 設定 Excel 檔案路徑
$excelFolderPath = Join-Path -Path $PSScriptRoot -ChildPath ".xlsx"
$excelFilePath = Join-Path -Path $excelFolderPath -ChildPath "UserListAndLicense.xlsx"

# 讀取 UserList 和 License 頁籤資料
$users = Import-Excel -Path $excelFilePath -WorksheetName "UserList"
$licenses = Import-Excel -Path $excelFilePath -WorksheetName "License"

# 獲取指定的 SKU 授權
foreach ($license in $licenses) {
    Write-Host "正在處理授權 SKU: $($license.SkuPartNumber)" -ForegroundColor Cyan
    $Sku = Get-MgSubscribedSku | Where-Object { $_.SkuPartNumber -eq $license.SkuPartNumber }

    # 檢查 SKU 是否有效
    if (-not $Sku) {
        Write-Host "無法找到對應的 SKU: $($license.SkuPartNumber)" -ForegroundColor Red
        continue
    }

    # 顯示 $Sku 資訊
    Write-Host "找到對應的 SKU 資訊:" -ForegroundColor Green
    Write-Host "SKU ID: $($Sku.SkuId)" -ForegroundColor Yellow
    Write-Host "SKU Part Number: $($Sku.SkuPartNumber)" -ForegroundColor Yellow

    # 確保 SkuId 是 GUID 格式
    $skuId = [Guid]::Parse($Sku.SkuId.ToString())
    Write-Host "轉換後的 GUID SkuId: $skuId" -ForegroundColor Green

    foreach ($user in $users) {
        try {
            # 設置使用者的服務位置
            #Write-Host "正在更新使用者: $($user.UserPrincipalName) 的服務位置為 $($user.UsageLocation)" -ForegroundColor Cyan
            Update-MgUser -UserId $user.UserPrincipalName -UsageLocation $user.UsageLocation

            # 指派 SKU 授權 (明確使用陣列格式)
            $addLicenses = @(@{SkuId = $skuId.ToString()})
            #Write-Host "正在為使用者 $($user.UserPrincipalName) 指派 SKU 授權: $($license.SkuPartNumber)" -ForegroundColor Cyan
            Set-MgUserLicense -UserId $user.UserPrincipalName -AddLicenses $addLicenses -RemoveLicenses @()

            #Write-Host "已成功指派 $($user.UserPrincipalName) 授權 $($license.SkuPartNumber)" -ForegroundColor Green
        } catch {
            Write-Host "指派授權時發生錯誤: $($_.Exception.Message)" -ForegroundColor Red
        }
    }
}

# 斷開與 Microsoft Graph 的連接
Disconnect-MgGraph
