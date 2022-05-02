[![Test](https://github.com/kijimaD/stale-file/actions/workflows/test.yml/badge.svg)](https://github.com/kijimaD/stale-file/actions/workflows/test.yml)
# StaleFile

StaleFile is GitHub Actions for checking stale file and reporting.

Use cases:

- Keep documents fresh
- Help motivate you to write book chapter by chapter

![userlmn_0d20af524795a3d0cf57718337d4b364](https://user-images.githubusercontent.com/11595790/166137520-23739a9c-c662-47b2-9c59-59f8cc8b974a.png)

## Usage

minumum settings example:

```yml
steps:
- uses: kijimaD/StaleFile@v0.0.4
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }} # need write permission
```

full settings example:

```yml
name: StaleFile

on:
  schedule:
    - cron: "0 0 1 * *" # per month
  workflow_dispatch:

jobs:
  stale_file:
    runs-on: ubuntu-latest

    steps:
      - uses: kijimaD/StaleFile@v0.0.4
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          label: 'StaleFile'
          file_extension: '*.md'
          include: '/doc'
          days_until_stale: 90
          issue_comment: 'Please check!'
```

## ⚠Workflow permission

This workflow need write token.
If you use `secrets.GITHUB_TOKEN`(default token), confirm to token having write permission(on Settings -> Actions -> General).

![image](https://user-images.githubusercontent.com/11595790/166137102-a14395bf-a54e-4c2e-a875-b081bbf5c10e.png)

## Test script

```shell
docker-compose up
```
