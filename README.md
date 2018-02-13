# GIT hooks examples

## Requiremenets

Due to mostly scripts will be written in Ruby, __your dev system should has globally available Ruby__.

## Installation

1. Go to `.git/hooks` folder of your project
2. Clone the repo under the current directory
   ```
   git clone git@github.com:brainagency/git-hooks.git .
   ```
3. Copy the example files (with `.example` extension) into the ones without any extension. That should be done to able to checkout fresh versions.
4. Profit!

## commit-msg hook

In order to:
   * make commit messages more standartized
   * make commit message to tell what this particular commit provides
   * make commit message more convenient for the other developers

the following rules will be applied:
   * main line MUST to not contain issue number.
     Mostly issue number is useful for the tickets systems, CI systems and others, but not for
     developers. Actually issue number takes a lot of space, which is not so big, to write
     meaningful commit description, because mostly everywhere git shows only this first line.
   * main line MUST has length not more than 50 characters.
     Of course you can write more, but only 50 characters will be showen, for example, in the
     bitbucket and other systems.
   * additional lines MUST has issue number OR `[no-issue]` label
     In order to allow specialized systems to link commits and issues. If you do not want that,
     just add `[no-issue]` label. Also you can skip issue number if a branch name already has it.
   * additional lines MUST has more detailed description about what this commit carries inside
     For example: what was the problem and what is a solution, what has been improved and so on.
   * additional lines could contain `[no-description]` or `[no-desc]` label
     It is not recommended, though, but you can.

## Contributions

All contributions are welcome and required! Feel free to make a fork and send PRs! Let's make our
development more better!
