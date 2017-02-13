# vim-tweaks
My personal configuration tweaks for [VIm editor](http://www.vim.org)

## About
This plugin contains my custom tweaks on VIm configuration. I've put them in a separate git repository because I use [Vundle](http://github.com/gmarik/vundle) in my [.vimrc](https://github.com/webastien/vim). I'm using [iTerm2](http://iterm2.com) on Mac, with a black theme (colors could be different in other consoles). I'm french so my shortcuts are for Mac azerty keyboards.

## Main features
* Swap files are no more in each edited files' directory, but all in **.vim/swapfiles** (so, they will not be embedded in FTP transferts, archives, ...)
* Paste a text on another do not replace the clipboard
* When opening a file, the cursor goes where it was the last time
* Search for word(s) in a directory and to navigate into results
* The **à** key (fr keyboards) works as **0** (begin of current line)

## Custom shortcuts
* **CTRL-F** to search something, somewhere
* **F6** Go to previous result of this search
* **F7** Go to next result of this search
* **F2** Toggle autopreview
* **SHIFT-Q** Return to last edited line
* **SPACE** Fold / Unfold
* **SHIFT-C** Comment / Uncomment line or selected block
* **CTRL-SPACE** (insert mode) Autocompletion
* **CTRL-T** New tab
* **CTRL-W** Close tab
* **LEFT** Previous tab
* **RIGHT** Next tab
* **UP** Previous pane
* **DOWN** Next pane
* **CTRL-K** Page up
* **CTRL-J** Page down
* **CTRL-H** Begin of line
* **CTRL-L** End of line
* **TAB** / **SHIFT-TAB** (normal mode) Indent more / less line or selected block
* **SHIFT-K** Move the current line up
* **SHIFT-J** Move the current line down
* **F3** Jump to declaration of the function / class / ... under the cursor
* **F4** Jump to declaration of the function / class / ... given by prompt
* **F5** Create / Refresh tags list of the project
* **F8** Toggle file outline
* **+** Auto align with tabular (detect ":" or "=" context)

## TODO
* Better language abstraction on some things (especially vim-ctags plugin)
* Re-do an acceptable helper module for [Drupal](https://www.drupal.org) when I will use D8 (I've started [one for D7](https://github.com/webastien/vim/blob/4b4f5c332e7576dd986da2e08a2e8b2ea7a2039f/vim/plugin/drupal.vim), but never had time to finish).
* Same for [Symfony2](http://symfony.com) and probably other frameworks / CMS / languages if I use vim to work with
* ...

