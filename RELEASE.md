# Releasing the Koalagator gem

We release Koalagator to the RubyGems package repository and we also create releases on Github.

Steps to release a gem.

### 1. Update dependencies

Update all gems in Gemfile.lock to the newest versions within our Gemfile constraints.

    $ bundle update

Run bundle outdated to see if there are other updates that could be relevant patches and updates that improve security & reliability.

    $ bundle outdated --filter-minor

Dependabot may have submitted pull requests for these updates, so check there to see if those can be merged now.
If not, update the Gemfile, and then run `bundle install` to install the specific new versions.

    $ bundle install

At this point, run all the tests. If something fails, downgrade one by one until you can figure out what caused the issue. Push these updates to `main` on Github, so the tests also run in the Github CI.

After updating dependencies, look at CHANGES.md, and make sure there are entries for all user and externally facing pull requests that have been merged, as well as configuration and platform changes. Also add a CHANGES.md entry summarizing dependencies, especially if they fix bugs or address security issues.

### 2. Ensure that ALL specs are passing

    rails spec && standardrb --fix && bundle exec appraisal install && bundle exec appraisal rails spec

### 2. Make a dedicated branch for the release

Lets say you are releasing version 99.1.0

    git checkout -b 99.1.0 # note that the branch is just 99.1.0 NOT v99.1.0 ('v' as in v99.1.0 is kept for tag naming).

### 3. Update CHANGES.md with the new release

    Update CHANGES.md & commit

### 4. Bump the version

We are using the gem-release gem. The `tag` flag creates a new commit and then tags it.

#### Patch: Usually for security fixes and very tiny changes (No real new features).

    gem bump --version patch --tag --file lib/calagator/version.rb

#### Minor: New features but no breaking changes.

    gem bump --version minor --tag --file lib/calagator/version.rb

#### Major: Breaking Changes or very significant release with very significant feature changes.

    gem bump --version major --tag --file lib/calagator/version.rb

### 5. Run bundle to update the Gemfile.lock with the new version number    

    bundle install && standardrb --fix 

Then commit the changes
    
    git commit -am "Update version in Gemfile.lock"
    
Then push the updated Gemfile.lock to the branch on origin.

    git push

### 6. Create the release on Github

Go to Github and manually create a release.

1. Visit  https://github.com/koalagator/koalagator/releases > 'Draft a new release'
2. Under 'Target' pick the branch eg '99.1.0'
3. Under 'Tag', 'create new tag' and use this format 'v0.0.0' eg v99.1.0
4. Press 'Generate release notes' it should set a release title in the format 'v0.0.0' eg v99.1.0 and create text in Write.
5. Make a new heading Major Changes and move major items up to this section.
6. Add a human summary at the top to make the release more understandable and attractive.
7. Set as the latest release. You can optionally 'create a discussion for this release'.
8. Click 'Publish release'

### 7. In Github initiate a new PR to merge the branch into main. 

Once checks all pass, merge the PR. DONT delete the branch! 
The branch is kept open to allow for future security/patch releases as needed.

### 8. From your local terminal, push the gem file to rubygems

With everything else resolved, pull the latest update to main.

    git checkout main

    git pull

Then make the RubyGems.org release:

    gem release

What gem release does:

    1. Builds the gem and makes a file eg koalagator-99.1.0.gem
    2. Pushes the .gem file to rubygems.org 'releasing it'.
    3. Deletes the .gem file locally. You can always gem build it later if needed.

### Tell everyone!

You can go to our RubyGems page to see that it looks correct. Take the link for this release and share it on [Mastodon](https://fosstodon.org/@koalagator)!