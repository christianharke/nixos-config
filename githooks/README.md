# Git hooks

```bash
# Copy the required hook templates
cp post-commit{.template,}

# Change the hook scripts accordingly
code post-commit

# Symlink the git hooks to this directory
rm -rf ../.git/hooks && ln -sf $(pwd) ../.git/hooks
```
