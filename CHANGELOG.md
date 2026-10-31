# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

## [2.0.4] - 2026-10-31

### Changed

- Bumped the project patch version to `2.0.4`.
- Routed AWS deployment through GitHub’s `production` environment, restricted to the `main` branch.
- Updated the Docker release workflow to use `docker/login-action` 4.7.0.

## [2.0.3] - 2026-10-16

### Added

- **Server error page** — publish `/500.html` for CloudFront 5xx fallbacks.

### Changed

- **Theme** — update to `aboutme-v2-theme` `0.4.2`.
- **Deployment** — migrate the GitHub Actions workflow from GitHub Pages to the existing AWS S3 and CloudFront stack.
- **CI dependencies** — retry transient Go module proxy failures before deployment.

## 1.0.1

### Changed

- Initial Release
