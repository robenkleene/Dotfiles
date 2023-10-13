%

# `codesign`

- `codesign -dvvv <path>`: Check code sign status
- `codesign --verify --verbose  <path>`: Verify code sign
- `codesign --force --options runtime --sign "Developer ID Application" <path>`: Re-sign
- `codesign -dvvv --entitlements=- <path-to-app>`: List entitlements
