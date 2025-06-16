# Write

```
defaults write com.barebones.bbedit Editor_ModernWordMovement -bool YES
```

# Read

```
defaults read com.barebones.bbedit Editor_ModernWordMovement
```

# Delete

```
defaults delete com.barebones.bbedit Editor_ModernWordMovement
```

# Reset

To delete an apps preferences:

```
defaults delete "com.domain.AppName"
defaults delete NSGlobalDomain NSAutomaticWindowAnimationsEnabled
```
