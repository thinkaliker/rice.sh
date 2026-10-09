# rice-source

Common functions shared by the rice- scripts. Not run on its own (rice.sh hides it from the menu).

Source it at the top of a rice- script:

```bash
source "$(dirname "${BASH_SOURCE[0]}")/../rice-source/rice-source.sh"
```

Function | Description
---------|------------
`rice_header NAME` | Prints the opening banner, "Ricing out: NAME" and the distro.
`rice_footer` | Prints the closing banner.
`check_sudo` | Prompts for the sudo password up front if not root.
`run_with_pkgmgr FUNC NAME` | Detects apt/yum, sets `PKGMGR_SUPPORTED`, runs `FUNC`, then prints the footer.
`ensure_curl` | Returns 0 if curl is available, running rice-base to install it if needed.
