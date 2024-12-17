# 使用必要的權限連接到 Microsoft Graph
Connect-MgGraph -Scopes "Group.Read.All", "Directory.Read.All", "RoleManagement.Read.Directory"

# 獲取所有群組
$groups = Get-MgGroup -All -Property "id,displayName,groupTypes,securityEnabled,mailEnabled,mail,createdDateTime"

# 初始化陣列來儲存群組詳細資訊
$groupDetails = @()

foreach ($group in $groups) {
    try {
        # 僅查詢特定群組類型
        if ($group.GroupTypes -contains "Unified" -or $group.MailEnabled) {
            # 此處可添加特定邏輯以處理 Unified 或 MailEnabled 群組
        } else {
            # 此處可添加特定邏輯以處理其他類型的群組
        }

        # 判斷是否為 Teams 群組
        $isTeamsGroup = if ($group.GroupTypes -contains "Unified") { "是" } else { "否" }

        # 格式化群組資訊
        $groupInfo = [pscustomobject]@{
            群組名稱       = $group.DisplayName
            群組類型       = if ($group.SecurityEnabled) { "安全性群組" } `
                            elseif ($group.MailEnabled) { "通訊群組" } `
                            else { "Microsoft 365 群組" }
            是否為Teams群組 = $isTeamsGroup
            郵件資訊       = if ($group.Mail) { $group.Mail } else { "沒有郵件資訊" }
            建立時間       = if ($group.CreatedDateTime) { [datetime]::Parse($group.CreatedDateTime).ToString("yyyy/MM/dd HH:mm:ss") } else { "未知" }
        }

        # 將群組資料加入陣列
        $groupDetails += $groupInfo
    } catch {
        Write-Host "查詢群組 (ID: $($group.Id)) 時發生錯誤：$($_.Exception.Message)"
    }
}

# 確保 .csv 資料夾存在
$csvFolderPath = Join-Path -Path $PSScriptRoot -ChildPath ".csv"
if (-not (Test-Path -Path $csvFolderPath)) {
    New-Item -ItemType Directory -Path $csvFolderPath | Out-Null
}

# 匯出為 CSV 並確認輸出路徑
$outputPath = Join-Path -Path $csvFolderPath -ChildPath "M365GroupsList.csv"
$groupDetails | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

# 顯示匯出完成訊息
Write-Host "結果已匯出至 $outputPath"

# 斷開與 Microsoft Graph 的連接
Disconnect-MgGraph

# 顯示斷開成功的消息
Write-Host "已成功斷開與 Microsoft Graph 的連接。"
