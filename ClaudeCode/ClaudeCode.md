# Claude Code

## cmds
- `/init` - initialize claude.md file for codebase
  - Keep claude.md in repo. If need machine specific use claude.local.md and add to gitignore
- `/terminal-setup` - terminal integration
  - Shift + Enter keybinding to add new line
- `#` - Add to memory of claude.md

## context
- `@Filepath\filename` - add to context; can add multiple files
- in vscode 
  - click on file to get into context
  - select portion of code for context
- `drag and drop` can also add to context
- clear context
  - `/exit` - terminate claude
  - `/clear` - clear session and history
  - `/compact` - summerize context; useful for long session
  - `ESC twice` - rewind to previous point 

## tools
- [tool ref](https://code.claude.com/docs/en/tools-reference)
- `/allowed-tools` - permission rules
- `Alt + m` - allow edits