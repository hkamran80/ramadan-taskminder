# Ramadan Taskminder

Stay on task for Ramadan!

[![Download](https://img.shields.io/badge/-download-%23A9C5B8?style=for-the-badge)](https://13willow.com/project/ramadan-taskminder?utm_source=gh)

Ramadan Taskminder allows you to stay on top of your tasks for Ramadan. Keep track
of your Qur'an reading, prayers, and other key tasks.

Ramadan Taskminder currently supports tasks, logging your Qur'an reading, and logging
your prayers. All data is stored on your device, and is not synced anywhere. No
diagnostics or analytics is collected.

If you have any feature requests, bug reports, or any other feedback, please
[contact us using this form](https://docs.google.com/forms/d/e/1FAIpQLScqajYl3qmnkdb48voPwN88LENp6XPxPh4eYQzgZUhAluqGWg/viewform).

## Development

Ramadan Taskminder is built with Flutter in Dart. Make sure that Flutter is installed and configured.

### Testing

1. Ensure your devices/emulators are connected. For Android, you can check with `adb devices`.
2. Run `flutter run`.

### Deployment

1. Run `flutter build appbundle` (Google Play), `flutter build apk` (standalone APK), and `flutter build ipa` (iOS).
2. Construct the release metadata in the doc and add it to each platform.
   - Upload the app bundle to Google Play Console and follow the release instructions.
   - Cut a new release on GitHub and upload the APK as a release asset with the name `Ramadan.Taskminder.apk`.
   - Upload the IPA to App Store Console via Transporter and follow the release instructions.
   - Update the changelog on 13W
