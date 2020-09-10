#!/usr/bin/env bash
set -e

main::magento() {
    /magento/bin/magento "$@"
}

main::main() {
    local output_dir
    output_dir="$(dirname "$INPUT_OUTPUT_FILE_PATH")"
    mkdir -p "$output_dir"

    main::magento i18n:collect-phrases "$INPUT_MODULE_PATH" -o "$INPUT_OUTPUT_FILE_PATH"
}

main::main "$@"
