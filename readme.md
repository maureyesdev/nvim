# Gekko vim

## Description

## Todo

- [ ] Add search in file - Is this even possible?
- [ ] Add a debugger for python and javascript at least
- [ ] Personalize lualine in order to display LspInfo and see what it got attached to the buffer
- [ ] Add highlight when copy
- [ ] Make the cmdline width absolute width and not relative width for buffer
- [ ] Personalize init dashboard - Maybe a gekko
- [ ] Add a restapi client
- [ ] Add a markdown previewer
- [ ] Add a notification plugin
- [ ] Add default languages for mason and treesitter
- [x] Behavior for neo-tree, when I Enter a file to automatically close neo-tree
- [ ] Add support for copilot
- [ ] Add treesitter selection, increase selection and decrease selection
- [ ] Add surround plugin
- [ ] Add support for closing buffers
- [ ] Add support for previous commands in cmdline
- [ ] Add support for multi cursor
- [ ] Adds support for chat gpt
- [ ] Adds spell check - URGENT
- [ ] Adds space inside braces

## Bugs?

- At least I was able to identify this in lua files. 
    - open nvim enter init.lua lsp will load correctly along with treesitter
    - but if a different file is being open, treesitter and lsp will sometimes load correctly, some of other times won't. Check for vim object
