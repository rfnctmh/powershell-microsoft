# 使用必要的權限連接到 Microsoft Graph
Connect-MgGraph -Scopes "Group.Read.All", "Directory.Read.All", "RoleManagement.Read.Directory"

# 獲取所有已訂閱的 SKU 並建立 SKU ID 和名稱的對應表
$skus = Get-MgSubscribedSku
$skuIdToNameMap = @{ }
foreach ($sku in $skus) {
    $skuIdToNameMap[$sku.SkuId.ToString()] = $sku.SkuPartNumber
}

# 獲取所有使用者，包含所需的屬性
$allUsers = Get-MgUser -All -Property 'UserPrincipalName', 'GivenName', 'DisplayName', 'AssignedLicenses', 'UserType', 'AccountEnabled', 'Department', 'JobTitle', 'CreatedDateTime'

# 初始化一個集合來存儲使用者和授權資訊
$LicensesUseList = @()

foreach ($user in $allUsers) {
    # 判斷是否為來賓使用者
    $isGuest = $user.UserType -eq "Guest"
    # 判斷帳號是否已封鎖
    $isBlocked = -not $user.AccountEnabled
    # 處理部門和職稱為空的情況
    $department = if ($user.Department) { $user.Department } else { "None" }
    $jobTitle = if ($user.JobTitle) { $user.JobTitle } else { "None" }
    $createdDate = $user.CreatedDateTime
    # 使用名字作為 Name
    $name = if ($user.GivenName) { $user.GivenName } else { "Unknown" }

    # 檢查使用者是否有授權
    if ($user.AssignedLicenses.Count -eq 0) {
        # 無授權
        $LicensesUseList += [PSCustomObject]@{
            UserPrincipalName = $user.UserPrincipalName
            Name              = $name
            DisplayName       = $user.DisplayName
            LicenseName       = "No License"
            Department        = $department
            JobTitle          = $jobTitle
            IsGuest           = $isGuest
            IsBlocked         = $isBlocked
            CreatedDate       = $createdDate
        }
    }
    else {
        foreach ($license in $user.AssignedLicenses) {
            try {
                # 比對 SKU 是否在訂閱中
                $licenseName = if ($skuIdToNameMap.ContainsKey($license.SkuId.ToString())) {
                    $skuIdToNameMap[$license.SkuId.ToString()]
                } else {
                    $license.SkuId # 顯示 SKU ID 當作授權名稱
                }

                $LicensesUseList += [PSCustomObject]@{
                    UserPrincipalName = $user.UserPrincipalName
                    Name              = $name
                    DisplayName       = $user.DisplayName
                    LicenseName       = $licenseName
                    Department        = $department
                    JobTitle          = $jobTitle
                    IsGuest           = $isGuest
                    IsBlocked         = $isBlocked
                    CreatedDate       = $createdDate
                }
            } catch {
                Write-Host "處理使用者 $($user.DisplayName) 的授權時出現錯誤：$_"
            }
        }
    }
}

# 假設 $groupDetails 是您要匯出的變數
if ($null -eq $LicensesUseList) {
    Write-Host "沒有可匯出的資料。"
} else {
    # 確保 csv 資料夾存在
    $csvFolderPath = Join-Path -Path $PSScriptRoot -ChildPath ".csv"
    if (-not (Test-Path -Path $csvFolderPath)) {
        New-Item -ItemType Directory -Path $csvFolderPath
    }

    # 匯出為 CSV 並確認輸出路徑
    $outputPath = Join-Path -Path $csvFolderPath -ChildPath "M365LicensesUseList.csv"
    $LicensesUseList | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

    # 顯示匯出完成訊息
    Write-Host "結果已匯出至 $outputPath"
}

# 斷開與 Microsoft Graph 的連接
Disconnect-MgGraph

# 顯示斷開成功的消息
Write-Host "已成功斷開與 Microsoft Graph 的連接。"
