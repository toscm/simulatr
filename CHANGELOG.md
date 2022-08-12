# Changelog

All notable changes to this project will be documented in this file.

The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), i.e.:

- There should be an entry for every single version.
- The latest version comes first.
- The release date of each version is displayed.
- The same types of changes should be grouped.
- The following keywords are used to denote different types of changes:
  - `Added` for new features
  - `Changed` for changes in existing functionality
  - `Deprecated` for soon-to-be removed features
  - `Removed` for now removed features
  - `Fixed` for bug fixes
  - `Security` in case of vulnerabilities
  - `Infrastructure` for updates of files not related to the package itself,
    e.g. .github/workflows/*, README.md, etc. Infrastructure updates increase
    the patch version.

## [0.1.1] - 2022-08-03

### Added

- dummy_func to make sure R CMD check recognizes that we're actually using the
  memoise

### Changed

- .csv files to .rds files
- simplest version of constant_batch_effect
- Readme.md

### Deleted

- 'gse' parameter from simulate_dataset

## [0.1.0] - 2022-08-05

- `Added`: Initial Version.
