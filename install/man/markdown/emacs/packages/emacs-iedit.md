# Emacs iedit

- `iedit-mode`: Start editing symbol at point, or matches for region if a region is selected

## Region

To change only matches in a region:

1. Put the point on the symbol, or select the region to be replaced
2. Toggle `iedit-mode` on
3. Select the region to only make changes within
4. Toggle `iedit-mode` again (all matches outside of the region will be unselected)
