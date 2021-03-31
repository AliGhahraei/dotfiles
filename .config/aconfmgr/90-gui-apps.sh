# Packages
AddPackage emacs # The best OS with a half-decent editor
AddPackage firefox-developer-edition # Developer Edition of Firefox web browser
AddPackage scrot # Simple command-line screenshot utility for X
AddPackage termite # Terminal emulator
AddPackage --foreign brave-bin # Blocks ads and trackers (binary release).
AddPackage --foreign ventoy-bin # A new multiboot USB solution (Binary)


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
AddPackage cmake # vterm needs it to (re)compile the executable


# Files
CopyFile /etc/group # Termite changes
