# rice-claude

Installs the Claude Code CLI (`claude`) using the native install script from claude.ai.

claude installs per-user into `~/.local/bin`, so run this as the user who will use it (not with sudo). Skips the install if `claude` is already on your PATH; use `claude update` to update. Requires curl; runs rice-base to install it if missing.
