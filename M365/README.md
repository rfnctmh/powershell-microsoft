# Microsoft Graph 管理腳本

這個專案包含了一系列 PowerShell 腳本，用於管理 Microsoft Graph 相關的功能。這些腳本可以幫助您安裝模組、設定執行政策、導出群組和授權資訊，以及卸載模組。

## 批處理檔案列表

### 1. `set_executionpolicy.bat`
- **功能**：設定 PowerShell 的執行政策，以允許腳本執行。

### 2. `setup_microsoft_graph_module.bat`
- **功能**：執行 `setup_microsoft_graph_module.ps1` 腳本以安裝 Microsoft Graph 模組。

### 3. `manage_m365licenses.bat`
- **功能**：執行 `manage_m365licenses.ps1` 腳本以管理 Microsoft 授權。

### 4. `manage_m365groups.bat`
- **功能**：執行 `manage_m365groups.ps1` 腳本以管理 Microsoft 365 群組。

### 5. `remove_microsoft_graph_module.bat`
- **功能**：執行 `remove_microsoft_graph_module.ps1` 腳本以卸載 Microsoft Graph 模組。

## 使用說明
1. 確保您的系統已安裝 PowerShell。
2. 所有批處理檔案在.bat的資料夾中。
3. 根據需要執行相應的批處理檔案：
 - 雙擊 `set_executionpolicy.bat` 設定執行政策。
 - 雙擊 `setup_microsoft_graph_module.bat` 安裝 Microsoft Graph 模組。
 - 雙擊 `manage_m365licenses.bat` 管理 Microsoft 授權。
 - 雙擊 `manage_m365groups.bat` 管理 Microsoft 365 群組。
 - 雙擊 `remove_microsoft_graph_module.bat` 卸載 Microsoft Graph 模組。

## 檔案存儲位置
所有導出的 CSV 檔案將存儲在語法路徑下的 `.csv` 資料夾中。如資料夾不存在，會自行建立，以便成功保存導出的資料。 

## 注意事項
- 如果遇到任何問題，請檢查 PowerShell 腳本中的錯誤訊息，並確保您的帳戶具有適當的 Microsoft Graph 訪問權限。

