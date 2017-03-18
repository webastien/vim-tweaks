# vim-tweaks
My personal configuration tweaks for [VIm editor](http://www.vim.org)

## About
This plugin contains my custom tweaks on VIm configuration. I've put them in a separate git repository because I use [Vundle](http://github.com/gmarik/vundle) in my [.vimrc](https://github.com/webastien/vim). I'm using [iTerm2](http://iterm2.com) on Mac, with a black theme (colors could be different in other consoles). I'm french so my shortcuts are for Mac azerty keyboards.

## Main features
* Search for word(s) in a directory and to navigate into results
* Custom statusline with full filepath
* Allows to move the current line up / down
* When opening a file, the cursor goes where it was the last time
* Paste a text on another do not replace the clipboard
* Disable swap files (temporary files with tilde)
* Auto-remove trailing spaces when saving a file
* Force indentation with spaces (2), not tabulation
* the <kbd>à</kbd> key (french keyboards) works as <kbd>0</kbd> (begin of current line)
* [Tabular plugin](https://github.com/godlygeek/tabular) requires no parameters with my custom key mapping
* [Syntastic plugin](https://github.com/scrooloose/syntastic) is set to show errors by default
* Allow to update your .vimrc by downloading a new one

## Configuration
The following option are optional, if you want to change their values, put it in your .vimrc.

### Prefilled URL for command `UpdateVimrc`
Curl is used to download the file, you will need to confirm the URL and the replacement. Default value:
```
let g:vim_tweaks__vimrc_url='https://raw.githubusercontent.com/webastien/vim/master/.vimrc'
```

### Altered filetypes
You can tell VIm to consider some files as a given filetype (`:h filetype` for more info). It's useful for syntax coloration and plugin based on filetypes. This plugin configure this filetypes alteration with a single dict variable. Keys are desired filetype, values are list of file pattern which will be associated with. Default value:
```
let g:vim_tweaks__filetypes = {
  \  'dosini': [ '*.info', '*.ini' ],
  \  'ruby':   [ 'Vagrantfile', 'Capfile' ],
  \  'sshconfig': [ '*/.ssh/config.d/*/config' ],
  \  'php':    [ '*.inc', '*.module', '*.theme', '*.install', '*.engine', '*.profile', '*.view', '*.test' ]
  \ }
```

**Only applied if default autocommands have not been disabled.**

**Note:**
* Those PHP filetypes work with [Drupal](https://www.drupal.org)
* This Ruby detection is useful when using [Vagrant](https://www.vagrantup.com) and [Capistrano](http://capistranorb.com)
* "sshconfig" detection is based on my [SSH config organization](https://github.com/webastien/dotfiles-mac/tree/master/ssh).

### Default command abbreviations
To disable them, simply use `let g:vim_tweaks__default_abbreviations = 0`

### Default keyboard mapping
To disable them, simply use `let g:vim_tweaks__default_mapping = 0`

### Default autocommands
To disable them, simply use `let g:vim_tweaks__default_autocommands = 0`

### Default options for vim editor
To disable them, simply use `let g:vim_tweaks__default_options_vim = 0`

### Default options for vim plugins
To disable them, simply use `let g:vim_tweaks__default_options_plugins = 0`

## Functions
* **AbbrebiationRemoveTrailingSpace()**, (internal use) helper function to remove the trailing space of an abbreviation
* **CommandAbbreviation(original, abbreviation)**, (internal use) helper function for my command abbreviations
* **LastPosition()**, replace the cursor on the last position in the file
* **SmartHome()**, toggle start of line / first nonblank character of the line
* **TabAuto()**, execute `tabularize` with auto-detected parameters ([Tabular plugin](https://github.com/godlygeek/tabular))
* **UpdateVimrc(url)**, update the .vimrc file with the given URL
* **WordSearch()**, search a word (the one under the cursor by default) in the given directory, recursively

To call them without a custom key map, simply type `:call WordSearch()` for example.

## Commands
* **:UpdateVimrc**, prompt for an URL, then update the `.vimrc` file with it (see [configuration section](#configuration) to prefill with your favorite)

## Default command abbreviations
(Can be disabled with option `g:vim_tweaks__default_abbreviations`.)

* **h**, open VIm help in a new tab if the current file is not a VIm help
* **e**, prefill the edit command with the full current path (reduced if in home)

## Default keyboard mapping
(Can be disabled with option `g:vim_tweaks__default_mapping`.)

* <kbd>CTRL</kbd><kbd>F</kbd> to search something, somewhere
* <kbd>F6</kbd> Go to previous result of this search
* <kbd>F7</kbd> Go to next result of this search
* <kbd>F2</kbd> Toggle autopreview
* <kbd>SHIFT</kbd><kbd>Q</kbd> Return to last edited line
* <kbd>SPACE</kbd> Fold / Unfold
* <kbd>SHIFT</kbd><kbd>C</kbd> Comment / Uncomment line or selected block
* <kbd>CTRL</kbd><kbd>SPACE</kbd> (insert mode) Autocompletion
* <kbd>CTRL</kbd><kbd>T</kbd> New tab
* <kbd>CTRL</kbd><kbd>W</kbd> Close tab
* <kbd>LEFT</kbd> Previous tab
* <kbd>RIGHT</kbd> Next tab
* <kbd>UP</kbd> Previous pane
* <kbd>DOWN</kbd> Next pane
* <kbd>SHIFT</kbd><kbd>K</kbd> Page up
* <kbd>SHIFT</kbd><kbd>J</kbd> Page down
* <kbd>SHIFT</kbd><kbd>H</kbd> Begin of line
* <kbd>SHIFT</kbd><kbd>L</kbd> End of line
* <kbd>TAB</kbd> / <kbd>SHIFT</kbd><kbd>TAB</kbd> Indent more / less current line or selected block
* <kbd>CTRL</kbd><kbd>K</kbd> Move the current line up
* <kbd>CTRL</kbd><kbd>J</kbd> Move the current line down
* <kbd>F3</kbd> Jump to declaration of the function / class / ... under the cursor
* <kbd>F4</kbd> Jump to declaration of the function / class / ... given by prompt
* <kbd>F5</kbd> Create / Refresh tags list of the project
* <kbd>F8</kbd> Toggle file outline
* <kbd>+</kbd> Auto align with tabular (detect ":" or "=" context)
* <kbd>;</kbd> Turn off searched terms highlighting
* <kbd>F10</kbd> Get the highlight group of the element under the cursor

