#!/bin/bash

# Run Cypress tests in headed mode
npx cypress run --headed

# Check if any tests failed
if [ $? -eq 0 ]; then
  echo "All tests passed. Checking for changes and proceeding with git operations."

  # Check if there are changes to commit
  if [[ -n $(git status -s) ]]; then
    # Check if a commit message is provided as a command-line argument
    if [ -z "$1" ]; then
      read -p "Enter a commit message: " commitMessage
    else
      commitMessage="$1"
    fi

    # Git operations
   sudo git pull
   sudo git add .
   sudo git commit -m "$commitMessage"
   sudo git push

    # Display success message
    echo "All checks passed! Pushed your changes to the repo."
  else
    echo "No changes to commit. Skipping git operations."
  fi
else
  echo "Some tests failed. Cannot proceed to commit the code. Please check your error images /cypress/screenshots"
fi

