# Magento 2 l18n phrases extractor

# Usage
Supported options:

`module_path` - Location of magento module, defaults to `.`
`output_file_path` - Location where translations should be generated

# Example use
```yaml
name: Example action

on:
  push:
    branches: [ master ]

jobs:
  synchronize-with-crowdin:
    runs-on: ubuntu-latest

    steps:

    - name: Checkout
      uses: actions/checkout@v2

    - name: locale extraction action
      uses: Szpadel/magento-l18n-extractor-action
      with:
        output_file_path: "l18n/en_US.csv"
```
