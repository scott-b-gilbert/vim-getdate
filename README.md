# vim-getdate
Vim plugin to convert a hexadecimal unix epoch time to human-readable format

Currently it supports:
* [_getdate_](https://github.com/scott-b-gilbert/getdate)
* *:GetDate <expression>* command, that will launch _getdate_ in command mode and output the result in a new split.
* \<LEADER\>da binding for new operator (getdate operator) that will run _getdate_ in command mode.

## Usage examples
* viw - \<LEADER\>da  - Run _getdate_ on expression highlighted

## Installation
Make sure you have _getdate_ installed and available in your $PATH.

### Manual

Just drop the getdate.vim into ~/.vim/plugin folder.

### Vim-Plug

Add the following line to _Vim-plug_
```Plugin 'scott-b-gilbert/vim-getdate'```
Run ```PlugInstall```

## Contribution
I'm not a real vim-script developer and I'm sure that the plugin can be
standarized and made better, if you happen to know vim-script, contributions are most welcome.

## Notice
This README and much of the code is cribbed from mellowcandle/vim-bitwise.
Credit where credit is due.


