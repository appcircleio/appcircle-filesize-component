# Appcircle _File size check_ component

Checks the file size of build artifacts.

## Optional Inputs

- `AC_ANALYZER_SOURCE_PATH`: Path of your artifacts. Full path of APK, AAB or IPA file. Don't change it to use default artifacts.
- `AC_ANALYZER_FILESIZE_THRESHOLD`: File size. File size threshold of the artifacts in mega bytes. Enter 0 to disable the check.
- `AC_ANALYZER_FILESIZE_ACTION`: File size check action. Create warning or fail the workflow if threshold limit is passed
