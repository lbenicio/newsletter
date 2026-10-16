# Changelog

All notable changes to this project will be documented in this file.

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
