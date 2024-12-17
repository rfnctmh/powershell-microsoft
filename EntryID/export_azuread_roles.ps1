# 連接到 Azure AD
Connect-AzureAD

# 獲取所有角色
$roles = Get-AzureADDirectoryRole

# 初始化一個空的集合來存儲角色和成員資訊
$roleMembersList = @()

# 列出所有角色及其成員
foreach ($role in $roles) {
    $members = Get-AzureADDirectoryRoleMember -ObjectId $role.ObjectId
    foreach ($member in $members) {
        # 將角色和成員資訊添加到集合中
        $roleMembersList += [PSCustomObject]@{
            角色名稱          = $role.DisplayName
            成員顯示名稱 = $member.DisplayName
            成員UPN         = $member.UserPrincipalName
        }
    }
}

# 確保 .csv 資料夾存在
$csvFolderPath = Join-Path -Path $PSScriptRoot -ChildPath ".csv"
if (-not (Test-Path -Path $csvFolderPath)) {
    New-Item -ItemType Directory -Path $csvFolderPath | Out-Null
}

# 將結果導出為 UTF-8 編碼的 CSV 文件並保存到指定路徑
$outputPath = Join-Path -Path $csvFolderPath -ChildPath "AzureADRolesAndMembers.csv"
$roleMembersList | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

# 顯示導出成功的消息
Write-Host "角色及其成員資訊已成功導出到 $outputPath"

# 關閉與 Azure AD 的連接
Disconnect-AzureAD
Write-Host "已成功斷開與 Azure AD 的連接。"
