# Starter Package

Base project for starting out with C# class libraries.

## Make it your own

To make this project your own, run the script `.\rename-project.ps1`:

```powershell
# Make this project your own.
# - rename files and folders to "Some.Repo"
# - specify the git repository url as "https://github.com/isaac-brown/some-repo"
# - with the author set to "Joe Blogs"
$ .\rename-project.ps1
project name: Some.Repo
git repository: https://github.com/isaac-brown/some-repo
author: Joe Blogs
```

## Getting started

Main thing that **should** be done when you download this is to install npm packages. While this isn't required to build, run or test the project it is used to manage local git hooks and perform releases.

To get started run the following command:

```bash
# Install local git hooks and release tools.
npm install
```

## Building Starter

To build this package run the following command:

```bash
# Build the library.
npm run build
```

## Running Starter Unit Tests

To run the unit tests for this package a single time:

```bash
# Run unit tests once
npm test
```

Or to watch for changes and re-run tests automatically:

```bash
# Run unit tests each time a change is made.
npm run test:watch
```

## Releasing Starter

Releasing can be done in one of the following ways:

| #   | Release type                        | Command                   |
| --- | ----------------------------------- | ------------------------- |
| 1   | [Cut a release](#cut-a-release)     | `npm run release`         |
| 2   | [Preview release](#preview-version) | `npm run release:preview` |
| 3   | [Dry release](#dry-release)         | `npm run release:dry`     |

### Cut a Release

To perform a release, run the following:

```bash
npm run release
```

This will do the following:

- Bump version in `package.json`, `package-lock.json` and `src/Starter/Starter.csproj`
- Write changes to `CHANGELOG`
- Commit all staged changes
- Tag release in git

### Preview Release

A preview version is supposed to be created when changes have been made, but a full release build isn't required just yet. This is basically a beta.

> Note that preview builds do not generate git tags, nor do they amend the `CHANGELOG` of the project, they just modify the version.

If you want to create a preview version, just run:

```bash
# Create preview version.
npm run release:preview
```

For example, if the current version is `1.1.0` and you have the following commit history:

```bash
* feat: another really neat feature
|
* chore(release): 1.1.0
|
* feat: something really neat
¦
```

Then if you run:

```bash
npm run release:preview
```

The git graph will then become:

```bash
* chore(release): 1.2.0.preview.0
|
* feat: another really neat feature
|
* chore(release): 1.1.0
|
* feat: something really neat
¦
```

And `package.json`, `package-lock.json` and `src/Starter/Starter.csproj` should now have a `version` of `1.2.0.preview.0`.

### Dry Release

To perform a dry run of the release (which might be useful to see what's going to happen), run the following:

```bash
npm run release:dry
```

This will just print output of what would happen if a release was cut. There are no side effects.
