#!/bin/bash

SCORE=0

echo "Running automated grading..."

# 1. Check student user defined
if grep -q "name: student" cloud-init/user-data.yaml; then
  echo "✔ student user defined"
  SCORE=$((SCORE+25))
else
  echo "✘ student user missing"
fi

# 2. Check zsh installation
if grep -q "zsh" cloud-init/user-data.yaml; then
  echo "✔ zsh referenced"
  SCORE=$((SCORE+25))
else
  echo "✘ zsh missing"
fi

# 3. Check Oh My Zsh installer
if grep -q "ohmyzsh" cloud-init/user-data.yaml || grep -q "install.sh" cloud-init/user-data.yaml; then
  echo "✔ Oh My Zsh installer found"
  SCORE=$((SCORE+25))
else
  echo "✘ Oh My Zsh installer missing"
fi

# 4. Check SSH key placeholder replaced
if ! grep -q "REPLACE_WITH_YOUR_PUBLIC_KEY" cloud-init/user-data.yaml; then
  echo "✔ SSH key provided"
  SCORE=$((SCORE+25))
else
  echo "✘ SSH key not replaced"
fi

echo ""
echo "FINAL SCORE: $SCORE / 100"

if [ "$SCORE" -lt 70 ]; then
  echo "Result: FAIL"
  exit 1
else
  echo "Result: PASS"
fi