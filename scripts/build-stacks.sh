#!/bin/sh
set -eu

root="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"

container system start

container build --file "$root/machine/alpine/Containerfile" --tag local/alpine-base:latest "$root"
container build --file "$root/machine/alpine/dev.Containerfile" --tag local/alpine-dev:latest "$root"

for file in "$root"/machine/alpine/stacks/*.Containerfile; do
  name="$(basename "$file" .Containerfile)"
  container build --file "$file" --tag "local/alpine-${name}:latest" "$root"
done
