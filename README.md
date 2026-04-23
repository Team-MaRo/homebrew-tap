# Team-MaRo Tap

[![License](https://img.shields.io/github/license/Team-MaRo/homebrew-tab)](LICENSE.txt)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.0-4baaaa)][code-of-conduct]

## How do I install these formulae?

`brew install Team-MaRo/tap/<formula>`

Or `brew tap Team-MaRo/tap` and then `brew install <formula>`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "Team-MaRo/tap"
brew "<formula>"
```

## Formulae

- **cc-statusline** — customizable Claude Code statusline. Prebuilt-binary formula; downloads the matching release asset from [`Team-MaRo/cc-statusline`](https://github.com/Team-MaRo/cc-statusline). `version` + `sha256` are kept current by `.github/workflows/bump-cc-statusline.yml` (manual *Bump cc-statusline formula* run, or `repository_dispatch` from the cc-statusline release workflow). The bump reads each asset's sha256 digest from the GitHub API — no `.sha256` files needed.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## Contributing

Please read [CONTRIBUTING.md][contributing] for details on our code of conduct and the process for submitting pull requests.

This project uses [Conventional Commits](https://www.conventionalcommits.org/).

## Versioning

We use [SemVer](http://semver.org/) for versioning. For available versions, see the [tags on this repository][gh-tags].

## Authors

### Special thanks for all the people who had helped this project so far

- **Manuele** - [D3strukt0r](https://github.com/D3strukt0r)

See also the full list of [contributors][gh-contributors] who participated in this project.

### I would like to join this list. How can I help the project?

We're currently looking for contributions for the following:

- [ ] Bug fixes
- [ ] Translations
- [ ] etc...

For more information, please refer to our [CONTRIBUTING.md][contributing] guide.

## License

This project is licensed under the MIT License - see the [LICENSE.txt](LICENSE.txt) file for details.

## Acknowledgments

This project currently uses no third-party libraries or copied code.

[gh-tags]: https://github.com/Team-MaRo/homebrew-tap/tags
[gh-contributors]: https://github.com/Team-MaRo/homebrew-tap/contributors
[contributing]: https://github.com/Team-MaRo/.github/blob/master/CONTRIBUTING.md
[code-of-conduct]: https://github.com/Team-MaRo/.github/blob/master/CODE_OF_CONDUCT.md
