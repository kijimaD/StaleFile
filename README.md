[![Test](https://github.com/kijimaD/stale-file/actions/workflows/test.yml/badge.svg)](https://github.com/kijimaD/stale-file/actions/workflows/test.yml)
# StaleFile

StaleFile is GitHub Actions for checking stale file and reporting.

Use cases:

- Keep documents fresh
- Help motivate you to write book chapter by chapter

## Usage

Basic: use default parameters

```yml
steps:
- uses: this@v2
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Test script

```shell
docker-compose up
```
