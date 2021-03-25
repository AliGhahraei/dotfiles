# Packages
AddPackage firefox-developer-edition # Developer Edition of Firefox web browser
AddPackage termite # Terminal emulator
AddPackage emacs # The best OS with a half-decent editor


## Doom Emacs dependencies

### Core
#### Required
AddPackage ripgrep
#### Optional
AddPackage fd # Improves performance for many file indexing commands in doom

### Config
AddPackage adobe-source-sans-pro-fonts # Cool variable pitch option for doom

### Modules
AddPackage pandoc # Enable doom markdown previews
AddPackage shellcheck # For shell script linting
AddPackage unzip # lsp-mode requires it to install servers


# Files
CopyFile /etc/group # Termite changes
