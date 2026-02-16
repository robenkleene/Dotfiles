- `benchmark-init/show-durations-tabulated`: Show in a table
- `benchmark-init/show-durations-tree`: Show a tree

# Enable

```
(use-package benchmark-init
  :ensure t
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))
```
