@echo off

setlocal

rem 獲取當前腳本的路徑
set "scriptDir=%~dp0"

rem 執行 PowerShell 腳本
powershell -ExecutionPolicy Bypass -File "%scriptDir%../setup_microsoft_graph_module.ps1"

pause