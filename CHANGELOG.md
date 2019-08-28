# Changelog

## Unreleased
- Plugin support
- Command line tool for global system

## [1.0.0](#100)
Released on 2019-08-06
### Added
- Adminer image
- MySQL 8.0.1
- PHP-FPM 7.1
- Nginx
- Command line tool `./myserver`
- Auto generate `docker-compose.yml` and `Dockerfile` 
- Support user preferences configs with `myserver.ini`

## [1.0.1](#101)
Released on 2019-08-17
### Fixed
- `Dockerfile` not auto generated
- Auto-build images not working
- Remove `--compress` option when build docker images

### Changed
- Change `./server` to `./myserver` in `README.md`

## [1.1.0](#110)
Released on 2019-08-28
### Changed
- `index.php` & `index.html` content

### Removed
- PHP5