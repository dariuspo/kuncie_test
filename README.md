# Kuncie Take Home Test
This repository is contains test for Kuncie

<p float="center">
  <img src="https://raw.githubusercontent.com/dariuspo/kuncie_test/main/assets/images/Dark.jpg" height="400">
  &nbsp; &nbsp; &nbsp; &nbsp;
  <img src="https://raw.githubusercontent.com/dariuspo/kuncie_test/main/assets/images/Light.jpg" height="400">
  &nbsp; &nbsp; &nbsp; &nbsp;
  <img src="[img]https://i.imgur.com/aU5g55Q.gif" height="400">
</p>


## Supported devices:
- Samsung Galaxy S10

## Supported features:
- Search music from itunes api based on artists name
- Play, pause, stop, prev, next music from api response
- Unit testing for Api Repository using Mocktail and blocTest
- Dark and light theme
- Using flutter navigator 2.0 with auto route to support easy deeplinking, named route, and route with parameter
- Using newest flutter version 2.10 to support Android Material 3
- Scalable code stucture with flutter bloc state management
- Using Dio + Retrofit to auto generate any new api request easily
- Using custom dio intetrceptor so can handle any kind of response and error response from different kind of server

## Requirements and Installation

This project requires [Flutter](https://docs.flutter.dev/get-started/install) to be installed.
For run with android emulator

```sh
cd to_project_path
flutter pub get
flutter run --debug (flutter run --release can be used in real device)
```

Or build APK first
```sh
cd to_project_path
flutter build apk
cd to_project_path\build\app\outputs\flutter-apk
copy app-release.apk to android emulator
```

