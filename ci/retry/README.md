# Retry Helper for Bitnion CI

This directory contains helper scripts used to retry commands during Bitnion CI runs.

## retry

The `retry` script is a small utility that retries a command several times if it fails.
This helps to mitigate flaky behavior in dependency downloads or remote commands.

### Usage

\`\`\`bash
./retry <command>
\`\`\`

## Example

\`\`\`bash
./retry curl -f -sSL https://example.org/resource.tar.gz -o resource.tar.gz
\`\`\`

## License

This file and the retry script are part of the Bitnion project and inherit its MIT license.
