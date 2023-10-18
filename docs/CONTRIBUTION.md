# Contribution Guidelines

Thank you for your interest in contributing to our project! We welcome contributions from everyone. To make the process as seamless as possible, we've outlined a set of guidelines to help you make the best possible contribution.

## Table of Contents

- [Contribution Guidelines](#contribution-guidelines)
  - [Table of Contents](#table-of-contents)
  - [Getting Started](#getting-started)
    - [Issues](#issues)
    - [Pull Requests](#pull-requests)
  - [Coding Standards](#coding-standards)
  - [Testing](#testing)
  - [Documentation](#documentation)
  - [Releases](#releases)


## Getting Started

### Issues

- Before creating a new issue, please do a search to see if it has already been reported. If it has, add a comment to the existing issue instead of opening a new one.
- Provide as much detail as possible when creating an issue. The more information, the easier it is for us to understand and address the problem.

### Pull Requests

- Make sure your PR is up-to-date with the main branch.
- If you're adding a feature or fixing a bug, please add tests!
- Describe what your PR does, the problem it solves, and reference any relevant issues.
- Please keep your PRs as small and concise as possible. Larger PRs can be hard to review, making them more likely to have bugs and less likely to get merged.

## Coding Standards

- Follow the coding style of the project.
- Include inline comments for important blocks of code.
- Use meaningful commit messages. If you're unsure about what constitutes a good message, see [this guide](https://chris.beams.io/posts/git-commit/).

## Testing

- Make sure all tests pass before submitting a pull request.
- Add new tests for every new feature or bug fix.
- If possible, include a screenshot or gif of the new feature or bug fix in action.

## Documentation

- Update the README.md or any relevant documentation if necessary.
- If you're adding a new feature, make sure to document it.
- Use clear and concise language.


## Releases

When a pull request is approved to be merged into the master branch, it's essential to update the `manifest.html` file to reflect the new release tag. 

Update the following lines in the `manifest.html` file:

```html
<p><b>Pipeline release:</b> Version.Major-release.Minor-release</p>
<a href="https://github.com/ctg-lund/singleCellWorkflows/archive/refs/tags/Version.Major-release.Minor-release.tar.gz">
```

**Versioning Guidance:**
- **Version**: Incorporate significant changes that might affect backward compatibility.
- **Major Releases**:  These releases typically introduce new features that do not affect backward compability.
- **Minor Releases**: Focus on bug fixes and slight optimizations without adding new features.
