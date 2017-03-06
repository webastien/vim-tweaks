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
* The **à** key (french keyboards) works as **0** (begin of current line)
* [Tabular plugin](https://github.com/godlygeek/tabular) requires no parameters with my custom key mapping
* [Syntastic plugin](https://github.com/scrooloose/syntastic) is set to show errors by default

## Keyboard shortcuts
* <kbd>CTRL</kbd> + <kbd>F</kbd> to search something, somewhere
* <kbd>F6</kbd> Go to previous result of this search
* <kbd>F7</kbd> Go to next result of this search
* <kbd>F2</kbd> Toggle autopreview
* <kbd>SHIFT</kbd> + <kbd>Q</kbd> Return to last edited line
* <kbd>SPACE</kbd> Fold / Unfold
* <kbd>SHIFT</kbd> + <kbd>C</kbd> Comment / Uncomment line or selected block
* <kbd>CTRL</kbd> + <kbd>SPACE</kbd> (insert mode) Autocompletion
* <kbd>CTRL</kbd> + <kbd>T</kbd> New tab
* <kbd>CTRL</kbd> + <kbd>W</kbd> Close tab
* <kbd>LEFT</kbd> Previous tab
* <kbd>RIGHT</kbd> Next tab
* <kbd>UP</kbd> Previous pane
* <kbd>DOWN</kbd> Next pane
* <kbd>CTRL</kbd> + <kbd>K</kbd> Page up
* <kbd>CTRL</kbd> + <kbd>J</kbd> Page down
* <kbd>CTRL</kbd> + <kbd>H</kbd> Begin of line
* <kbd>CTRL</kbd> + <kbd>L</kbd> End of line
* <kbd>TAB<kbd> / <kbd>SHIFT</kbd> + <kbd>TAB</kbd> Indent more / less current line or selected block
* <kbd>SHIFT</kbd> + <kbd>K</kbd> Move the current line up
* <kbd>SHIFT</kbd> + <kbd>J</kbd> Move the current line down
* <kbd>F3</kbd> Jump to declaration of the function / class / ... under the cursor
* <kbd>F4</kbd> Jump to declaration of the function / class / ... given by prompt
* <kbd>F5</kbd> Create / Refresh tags list of the project
* <kbd>F8</kbd> Toggle file outline
* <kbd>+</kbd> Auto align with tabular (detect ":" or "=" context)

