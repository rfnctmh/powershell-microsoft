# 連接到 Azure AD
Connect-AzureAD

# 使用 -All $true 確保獲取所有使用者
$users = Get-AzureADUser -All $true

# 初始化一個陣列來存儲結果
$roleAssignmentsList = @()

# 迴圈遍歷每個使用者並獲取其角色分配
foreach ($user in $users) {
    # 判斷是否為來賓使用者
    $isGuest = if ($user.UserType -eq "Guest") { "是" } else { "否" }

    # 獲取當前使用者的角色分配
    $roleAssignments = Get-AzureADUserAppRoleAssignment -ObjectId $user.ObjectId

    # 若該使用者有角色分配
    if ($roleAssignments) {
        foreach ($roleAssignment in $roleAssignments) {
            # 確保正確獲取角色名稱（角色名稱來自於 RoleAssignment 的 ResourceId）
            $roleDisplayName = $roleAssignment.ResourceDisplayName

            # 只將有角色分配的使用者寫入結果
            $roleAssignmentsList += [PSCustomObject]@{
                使用者    = $user.UserPrincipalName
                應用程式  = $roleDisplayName
                來賓      = $isGuest
            }
        }
    }
}

# 確保 .csv 資料夾存在
$csvFolderPath = Join-Path -Path $PSScriptRoot -ChildPath ".csv"
if (-not (Test-Path -Path $csvFolderPath)) {
    New-Item -ItemType Directory -Path $csvFolderPath | Out-Null
}

# 將結果導出為 UTF-8 編碼的 CSV 文件並保存到指定路徑
$outputPath = Join-Path -Path $csvFolderPath -ChildPath "AzureADAppAssignments.csv"
$roleAssignmentsList | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

# 顯示導出成功的消息
Write-Host "應用程式權限已成功導出到 $outputPath"

# 關閉與 Azure AD 的連接
Disconnect-AzureAD
Write-Host "已成功斷開與 Azure AD 的連接。"
