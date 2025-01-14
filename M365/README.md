# Microsoft Graph 管理腳本

這個專案包含了一系列 PowerShell 腳本，用於管理 Microsoft Graph 相關的功能。這些腳本可以幫助您安裝模組、設定執行政策、導出群組和授權資訊，以及卸載模組。

## 批處理檔案列表

### 1. `set_executionpolicy.bat`
- **功能**：設定 PowerShell 的執行政策，允許腳本執行。

### 2. `setup_microsoft_graph_module.bat`
- **功能**：執行 `setup_microsoft_graph_module.ps1` 腳本，安裝 Microsoft Graph 模組。

### 3. `manage_m365licenses.bat`
- **功能**：執行 `manage_m365licenses.ps1` 腳本，管理 Microsoft 授權。

### 4. `manage_m365groups.bat`
- **功能**：執行 `manage_m365groups.ps1` 腳本，管理 Microsoft 365 群組。

### 5. `manage_copilot.bat`
- **功能**：執行 `manage_copilot.ps1` 腳本，管理 Copilot 授權，提供使用者授權狀態報告並輸出結果到 CSV 檔案中。

### 6. `assign_licenses.bat`
- **功能**：執行 `assign_licenses.ps1` 腳本，使用於批量指派指定的使用者 Microsoft 授權。使用者資訊需從 Excel 檔案中的 UserList 頁籤中維護，並根據需求人工調整要指派的授權 SKU。

### 7. `remove_licenses.bat`
- **功能**：執行 `remove_licenses.ps1` 腳本，用於批量移除指定的使用者 Microsoft 授權。使用者資訊需從 Excel 檔案中的 UserList 頁籤中維護，並根據需求人工調整要移除的授權 SKU。

### 8. `remove_microsoft_graph_module.bat`
- **功能**：執行 `remove_microsoft_graph_module.ps1` 腳本，卸載 Microsoft Graph 模組。

## 使用說明
1. 確保您的系統已安裝 PowerShell。
2. 所有批處理檔案在.bat的資料夾中。
3. 根據需要執行相應的批處理檔案：
 - 雙擊 `set_executionpolicy.bat` 設定執行政策。
 - 雙擊 `setup_microsoft_graph_module.bat` 安裝 Microsoft Graph 模組。
 - 雙擊 `manage_m365licenses.bat` 管理 Microsoft 授權。
 - 雙擊 `manage_m365groups.bat` 管理 Microsoft 365 群組。
 - 雙擊 `manage_copilot.bat` 管理 Copilot 授權。
 - 雙擊 `assign_licenses.bat` 批量指派 Microsoft 授權。
 - 雙擊 `remove_licenses.bat` 批量移除 Microsoft 授權。
 - 雙擊 `remove_microsoft_graph_module.bat` 卸載 Microsoft Graph 模組。

## 檔案與資料夾管理
- **.bat 資料夾** 主要為執行批次檔使用，檔案和資料夾不可以刪除。
- **.csv 資料夾** 主要為生成授權和群組清單檔使用，檔案和資料夾可以刪除。
- **.xlsx 資料夾** 主要為維護指派或取消授權使用，檔案和資料夾不可以刪除。

## UserListAndLicense.xlsx
### UserList 工作表
| UserPrincipalName           | UsageLocation |
|-----------------------------|---------------|
| name.lastname@example.com   | TW            |

### License 工作表
| SkuPartNumber |
|---------------|
| SPE_E3        |

## 注意事項
- 如果遇到任何問題，請檢查 PowerShell 腳本中的錯誤訊息，並確保您的帳戶具有適當的 Microsoft Graph 訪問權限。