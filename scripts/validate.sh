#!/usr/bin/env bash
# Deterministic repo checks (issue #3). Run from the repo root, locally or in CI.
# Requires: bash, git, node. Exit 0 = all green.
set -u
fail=0
err() { printf 'FAIL: %s\n' "$*"; fail=1; }

# 1. Plugin manifest parses; name and version present.
node -e '
const m = require("./.claude-plugin/plugin.json");
if (!m.name || !m.version) process.exit(1);
console.log(`manifest ok: ${m.name}@${m.version}`);
' || err "plugin.json: invalid JSON or missing name/version"

# 2. Zero unresolved {{ placeholders in consumed files. Allowed to contain the marker:
#    templates/ (they ARE the placeholders), docs/ and CHANGELOG.md (historical record),
#    the bootstrap skill and its verifier (they teach the syntax), .github/ (Actions syntax).
hits=$(git grep -In '{{' -- \
  ':!templates' ':!docs' ':!CHANGELOG.md' ':!.github' \
  ':!skills/bootstrap/SKILL.md' ':!scripts/verify-bootstrap.ps1' \
  ':!scripts/validate.sh' || true)
if [ -n "$hits" ]; then
  printf '%s\n' "$hits"
  err "unresolved {{ placeholders (resolve them or add the file to the allowlist above)"
else
  echo "placeholders ok"
fi

# 3. Skill frontmatter: every skills/*/SKILL.md starts with ---, declares name: and a
#    description: that starts with "Use when".
for f in skills/*/SKILL.md; do
  [ "$(head -n1 "$f" | tr -d '\r')" = "---" ] || err "$f: does not start with ---"
  fm=$(awk 'NR==1{next} /^---\r?$/{exit} {print}' "$f")
  printf '%s\n' "$fm" | grep -q '^name:' || err "$f: frontmatter missing name:"
  printf '%s\n' "$fm" | grep -q '^description: Use when' \
    || err "$f: description must start with \"Use when\""
done
echo "frontmatter checked: $(ls skills/*/SKILL.md | wc -l) skills"

# 4. Internal markdown links resolve (inline links only, fragment stripped).
broken=""
for f in $(git ls-files '*.md'); do
  dir=$(dirname "$f")
  links=$(grep -oE '\]\([^)]+\)' "$f" | sed -E 's/^\]\(//; s/\)$//; s/ .*$//') || true
  for t in $links; do
    case "$t" in
      http://*|https://*|mailto:*|'#'*) continue ;;
    esac
    t="${t%%#*}"
    [ -z "$t" ] && continue
    [ -e "$dir/$t" ] || broken="$broken$f -> $t
"
  done
done
if [ -n "$broken" ]; then
  printf '%s' "$broken"
  err "broken internal links"
else
  echo "links ok"
fi

[ "$fail" -eq 0 ] && echo "ALL CHECKS PASSED"
exit "$fail"
