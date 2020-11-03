REM Set the environment variables needed for individual MSCV Build Tools

set %VSCMD_DEBUG% 4
@call "%~dp0vcvarsall.bat" x64 %*
