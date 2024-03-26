# Forking
How to release Koalagator / Calagator as your own Gem.

As of writing this guide, I am currently in the process of forking Calagator to become Koalagator.

I have decided to mostly keep the Calagator namespace for the code. It would be a big task to replace it,
and replacing it would provide very little benefit. As well, maintaining the same namespace should make it easier
to share and upstream code from named forks.

This guide has been written to hopefully make forking / upstreaming an easier task.

## Version
The version file holds much of the configuration needed to release a fork.
Here is it's configuration as of writing this guide.

```rb
# lib/calagator/version.rb
module Calagator
  NAME = "Koalagator"
  GEMSPEC = "koalagator"
  VERSION = "5.0.0"
  RAILS_VERSION = "~> 7.1"
end
```

The following are explanations of the constants:
- **NAME**: Distro name, used by the `distro_name` helper method. Used in a couple places where the name of the underlying app is shown to the user.
- **GEMSPEC**: The name of the gem, and gemspec. Used by [rails_template.rb](rails_template.rb), and the gemspec itself.
- **VERSION**: Version of the gem. Used by the gemspec.
- **RAILS_VERSION**: Version of rails. Used by the gemspec, and appraisals.

## Gemspec
The gemspec is, as of writing this, located at 'koalagator.gemspec'.

If you have changed the GEMSPEC constant, please rename the gemspec to match.

## Executable
You may also want to rename the executable used by the gem. If you do, rename the file 'bin/koalagator'
to whatever your new name is (probably best to match GEMSPEC).

You may want to replace references to 'Koalagator' in it to whatever your fork is called.

Also, in your gemspec, change the following line:
```
s.executables << "koalagator"
```
Replace 'koalagator', or whatever other executable name, with that of your own.

## Init file
The init file loads all aspects of the gem. As of writing this, it is 'lib/koalagator.rb',
which had been renamed from 'lib/calagator.rb'.

Rename this file to match your GEMSPEC constant.

## Install
Update references to 'Koalagator' in [INSTALL.md](INSTALL.md) to point your your gem.
