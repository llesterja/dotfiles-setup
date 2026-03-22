# Homebrew dotnet@8 is keg-only: host lives in bin/, runtime in libexec/.
# Source this after `brew shellenv` so `brew` is on PATH.
if command -v brew >/dev/null 2>&1; then
  _dotnet_prefix="$(brew --prefix dotnet@8 2>/dev/null)"
  if [[ -n "$_dotnet_prefix" && -x "$_dotnet_prefix/bin/dotnet" ]]; then
    export DOTNET_ROOT="$_dotnet_prefix/libexec"
    export PATH="$_dotnet_prefix/bin:$PATH"
  fi
  unset _dotnet_prefix
fi
