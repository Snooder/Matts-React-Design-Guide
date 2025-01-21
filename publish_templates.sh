#!/bin/bash

cd msnyder-templates/packages

for TEMPLATE_DIR in cra-template-msnyder-*; do
  echo "Publishing $TEMPLATE_DIR..."
  cd "$TEMPLATE_DIR"
  
  npm publish --access public

  cd ..
done

echo "All templates have been published!"
