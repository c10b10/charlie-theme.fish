# Charlie

A fish command promp based on [Charlie for Zsh](https://github.com/c10b10/charlie), and [brandonweiss's Pure port for fish](https://github.com/brandonweiss/pure.fish).

![](screenshot.png)

## Features

- Shows `git` branch and whether it's dirty (with a `*`) or wether it has
staged files (with a `+`).
- Indicates when you have unpushed/unpulled `git` commits with up/down arrows.
- If the command didn't exit with `0`:
    - The prompt character turns red
    - The exit code is displayed before the prompt character
- Username and host only displayed when in an SSH session.
- Shows the current path in the title and the current folder & command when a process is running.
- Makes an excellent starting point for your own custom prompt.
- Has SVN and Mercurial support.
- Shows [Python virtualenv info](https://github.com/c10b10/charlie/blob/master/charlie.zsh#L78-L93).

## Requirements

Requires git 2.3.0+ and Fish 2.4.0+.

## Installation

Clone in it your fish config directory, and init submodules...

```sh
$ cd ~/.config/fish
$ git clone https://github.com/c10b10/charlie.fish.git
$ cd charlie.fish
$ git submodule init --recursive
```

...and `source` it in `functions/fish_prompt.fish`:

```fish
. ~/.config/fish/charlie.fish/fish_prompt.fish
```

## License

MIT © Alex Ciobica

# Pure.fish

A [Pure][pure]-inspired prompt for [fish shell][fish]. It’s very similar to Pure, but not identical—it’s not intended to have feature parity.

![Screenshot of Pure.fish](https://cloud.githubusercontent.com/assets/4727/9908269/cc5a20d8-5c47-11e5-8cb9-4d45378a60f3.png)

*TL;DR*

* A clean, beautiful, and minimal prompt
* The perfect prompt character. Seriously. [Sindre Sorhus][sindre] went through the entire unicode range to find it. All other prompt characters bow before this prompt character. :heart:
* Takes up two lines with a blank space preceding it. At first I thought this was weird but now I can’t imagine going back.
* Shows the working directory
* Shows the current git branch or revision
* Shows up/down arrows if you have unpushed/unpulled commits
* The prompt character turns red if the last command’s exit status is 1

## Installation

fish doesn’t have any kind of plugin system so you just have to [download the file](https://raw.githubusercontent.com/brandonweiss/pure.fish/master/fish_prompt.fish) and save it as `~/.config/fish/functions/fish_prompt.fish`.

Here’s a one-liner you can run.

```shell
curl https://raw.githubusercontent.com/brandonweiss/pure.fish/master/fish_prompt.fish > ~/.config/fish/functions/fish_prompt.fish
```

To make it easier to update you can clone this repo and then symlink the prompt into place.

```shell
git clone https://github.com/brandonweiss/pure.fish.git
ln -s ./pure.fish/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
```

## Theme

You can of course use any terminal theme you like, but I think it looks best with [Tomorrow Night Eighties][tomorrow] and [Droid Sans Mono][droid] in 15pt (with anti-aliasing on).

## Contributing

1. Fork it ( http://github.com/brandonweiss/pure.fish/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am ‘Add some feature’`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[pure]: https://github.com/sindresorhus/pure
[fish]: http://fishshell.com
[sindre]: https://github.com/sindresorhus
[tomorrow]: https://github.com/chriskempson/tomorrow-theme
[droid]: https://www.google.com/fonts/specimen/Droid+Sans+Mono
