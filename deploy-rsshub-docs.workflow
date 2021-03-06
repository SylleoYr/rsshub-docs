name: build and deploy rsshub docs

on:
  push:
    branches:
      - main

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2.3.3
        with:
          fetch-depth: 0 # Fetch all history

      - uses: actions/setup-node@v2.1.2
        with:
          node-version: '12.x'

      - name: Cache dependencies
        uses: actions/cache@v2
        with:
          path: ~/.npm
          key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node-
      
      - name: update rsshub docs
        run: |
          git submodule update --init --checkout rsshub
      
      - name: build rsshub docs
        run: |
          cp rsshub-package.json rsshub/package.json
          cd rsshub
          npm i && npm run docs:build
          cd ..
      
      - name: deploy rsshub docs
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./rsshub/docs/.vuepress/dist