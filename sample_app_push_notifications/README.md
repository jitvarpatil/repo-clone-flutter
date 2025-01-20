
<p align="center">
  <img alt="CometChat" src="https://assets.cometchat.io/website/images/logos/banner.png">
</p>

# Flutter Sample App by CometChat

This is a reference application showcasing the integration of [CometChat's Flutter UI Kit](https://www.cometchat.com/docs/ui-kit/flutter/5.0/overview)  in a Flutter project. It demonstrates how to implement real-time messaging and voice/video calling features with ease.

<div style="display: flex; align-items: center; justify-content: center">
   <img src="./screenshots/overview_cometchat_screens.png" />
</div>

## Prerequisites

- Ensure you have the following installed:
    - Android Studio (latest stable version)
    - Java Development Kit (JDK 8 or later)

- Sign up for a [CometChat](https://app.cometchat.com/) account to obtain your app credentials: _`App ID`_, _`Region`_, and _`Auth Key`_

## Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/cometchat/cometchat-uikit-flutter.git
   ```

2. Checkout v5 branch:
   ```sh
   git checkout v5
   ```

3. Open the project in Android Studio by navigating to the cloned directory and open the `sample_app_push_notifications` folder.

4. Sync Gradle to ensure all dependencies are downloaded.

    5. `[Optional]` Configure CometChat credentials:
        - Open the `AppCredentials.dart` file located at `sample_app_push_notifications/lib/AppCredentials.dart` and enter your CometChat _`App ID`_, _`Region`_, and _`Auth Key`_:
          ```dart
           AppCredentials {
               static String _appId = "YOUR_APP_ID";
               static String _authKey = "YOUR_AUTH_KEY";
               static String _region = "REGION";
           }
         ```
    6. Set up Firebase Cloud Messaging (FCM) by following the below steps
        - Go to the [Firebase Console](https://console.firebase.google.com/) and create a project.
        - Add your Android and iOS app to the Firebase project
        - To use Firebase you would need the `google-services.json` and `GoogleService-Info.plist`. You can either download them or generate these files run the following steps.
        - Install Firebase CLI
            - Run the following command:
        ```shell
        curl -sL https://firebase.tools | bash
        ```
        - Login to Firebase
            - Log in using your Google account:
        ```shell
        firebase login
        ```
        - Install FlutterFire CLI
            - Execute this command:
        ```shell
        firebase pub global activate flutterfire_cli
        ```
        - Configure Firebase in Your Flutter Project
            - Use FlutterFire CLI to link Firebase to your Flutter project:
        ```shell
          flutterfire configure 
       ```
        - select the Firebase project you want to use.
        - Uncomment the following lines from `sample_app_push_notifications/lib/main.dart` file:
       ```dart
           import 'firebase_options.dart';
       ```
       ```dart
           import 'firebase_options.dart';
           await Firebase.initializeApp(
           // options: DefaultFirebaseOptions.currentPlatform,
           );
       ```
7. Set up CometChat Push Notification:
    - Go to the [Notification Documentation](https://www.cometchat.com/docs/notifications/push-integration) and follow integration steps.

8. Run the project using an emulator or a physical device to build and run the sample app.


## Help and Support

For issues running the project or integrating with our UI Kits, consult our [documentation](https://www.cometchat.com/docs/ui-kit/android/5.0/getting-started) or create a [support ticket](https://help.cometchat.com/hc/en-us). You can also access real-time support via the [CometChat Dashboard](http://app.cometchat.com/).