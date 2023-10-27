:: get your shit off my home directory bill gates
@if "%CD%" == "%USERPROFILE%" (
    ls --color=auto ^
        -I "AppData" -I "Contacts" -I "Favorites" -I "Links"^
        -I "Music" -I "My Documents" -I "Pictures" -I "Videos" -I "Saved Games" -I "Start Menu"^
        -I "NTUSER.*" -I "ntuser.*" -I "desktop.ini" -I "thumbs.db" -I "Thumbs.db"^
        -I "*.mdb" %*
) else (
    ls --color=auto %*
)
