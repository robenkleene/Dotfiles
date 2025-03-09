# Print variable

``` python
print("$1 = ", ${1})
```

# Print

``` python
print("${1:Message}")
```

# Print error

``` python
print("${1:Error}", file=sys.stderr)
```

# Python template

``` python
#!/usr/bin/env python3


```

# Python Blender template

``` python
import bpy

if bpy.data.objects.get("Cube"):
    bpy.data.objects["Cube"].select_set(True)
    bpy.ops.object.delete()

```

# `main` Function

``` python
def main():
	"""
	main
	"""
	
```

