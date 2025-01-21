#!/bin/bash

cd msnyder-templates/packages

for TEMPLATE_DIR in cra-template-msnyder-*; do
  echo "Updating $TEMPLATE_DIR..."
  cd "$TEMPLATE_DIR"

  npm version patch
  npm publish --access public

  cd ..
done

echo "All templates have been updated and published!"
