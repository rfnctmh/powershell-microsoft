# AzureAD 管理腳本

這個儲存庫包含一系列批處理檔案和 PowerShell 腳本，用於管理 Azure Active Directory (Azure AD) 模組。這些腳本可以幫助您安裝模組、導出使用者和角色資訊，以及卸載模組。

## 批次處理檔案列表

以下是可用的批處理檔案及其功能：

### 1. `set_executionpolicy.bat`
- **功能**：設定 PowerShell 的執行政策，以允許腳本執行。

### 2. `setup_azuread_module.bat`
- **功能**：檢查並安裝 AzureAD 模組（如果尚未安裝），然後導入模組並連接到 Azure AD。

### 3. `export_azuread_appassignments.bat`
- **功能**：導出所有使用者及其應用程式權限資訊到 CSV 檔案。

### 4. `export_azuread_roles.bat`
- **功能**：導出所有 Azure AD 角色及其成員資訊到 CSV 檔案。

### 5. `remove_azuread_module.bat`
- **功能**：卸載已安裝的 AzureAD 模組。


## 使用說明
1. 確保您的系統已安裝 PowerShell。
2. 所有批處理檔案在.bat的資料夾中。
3. 根據需要執行相應的批處理檔案：
 - 雙擊 `set_executionpolicy.bat` 設定執行政策。
 - 雙擊 `setup_azuread_module.bat` 安裝 AzureAD 模組。
 - 雙擊 `export_azuread_appassignments.bat` 導出應用程式權限。
 - 雙擊 `export_azuread_roles.bat` 導出角色及其成員資訊。
 - 雙擊 `remove_azuread_module.bat` 卸載 AzureAD 模組。

## 檔案存儲位置
所有導出的 CSV 檔案將存儲在語法路徑下的 `.csv` 資料夾中。如資料夾不存在，會自行建立，以便成功保存導出的資料。

## 注意事項
- 如果遇到任何問題，請檢查 PowerShell 腳本中的錯誤訊息，並確保您的帳戶具有適當的 Azure AD 訪問權限。
