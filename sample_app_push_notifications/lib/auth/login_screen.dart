import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';
import 'package:sample_app_push_notifications/dashboard.dart';
import 'package:sample_app_push_notifications/notifications/services/cometchat_services.dart';
import 'dart:async';
import 'package:bugsee_flutter/bugsee.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  loginToCometChat(fb.User user, Function(User) onSuccess,
      Function(CometChatException) onError) async {
    if (user.email != null) {
      Bugsee.setEmail(user.email!);
    }
    String uid = generateUID(user.email ?? "");
    CometChatUIKit.login(
      uid,
      onSuccess: onSuccess,
      onError: (error) {
        if (error.code == "ERR_UID_NOT_FOUND") {
          createCometChatUser(user, onSuccess, onError);
        } else {
          onError(error);
        }
      },
    );
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static final firebaseAuth = fb.FirebaseAuth.instance;

  fb.User? get currentUser => firebaseAuth.currentUser;

  Future<fb.UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final fb.AuthCredential credential = fb.GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final fb.UserCredential authResult =
        await firebaseAuth.signInWithCredential(credential);
    return authResult;
  }

  createCometChatUser(fb.User user, Function(User) onSuccess,
      Function(CometChatException) onError) async {
    String uid = generateUID(user.email ?? "");
    CometChatUIKit.createUser(
        User(uid: uid, name: user.displayName ?? "", avatar: user.photoURL),
        onSuccess: (_) {
      loginToCometChat(user, onSuccess, onError);
    }, onError: onError);
  }

  String generateUID(String email) {
    try {
      // Convert the email string to bytes (UTF-8 encoding)
      List<int> emailBytes = utf8.encode(email);

      // Create a SHA-256 hash from the email bytes
      var digest = sha256.convert(emailBytes);

      // Return the hexadecimal string representation of the hash
      return digest.toString();
    } catch (e) {
      throw Exception('Error generating UID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorPalette = CometChatThemeHelper.getColorPalette(context);
    final typography = CometChatThemeHelper.getTypography(context);
    final spacing = CometChatThemeHelper.getSpacing(context);

    return Scaffold(
      backgroundColor: colorPalette.background1,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(spacing.padding4 ?? 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              // CometChat Logo
              Image.asset(
                'assets/cometchat_logo_with_text.png',
                color: colorPalette.textPrimary,
              ),
              // Replace with your logo path
              const SizedBox(height: 150),
              // Title
              Text('Login',
                  style: TextStyle(
                    color: colorPalette.textPrimary,
                    fontSize: typography.heading2?.bold?.fontSize,
                    fontFamily: typography.heading2?.bold?.fontFamily,
                    fontWeight: typography.heading2?.bold?.fontWeight,
                  )),
              const SizedBox(height: 14),
              // Google Sign-in Button
              ElevatedButton(
                onPressed: () async {
                  final user = await signInWithGoogle();
                  if (user != null && user.user != null) {
                    loginToCometChat(user.user!, (user) async {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MyHomePage()));
                    }, (error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("${error.message}"),
                        backgroundColor: colorPalette.error,
                      ));
                    });
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: const Text("Unable to Sign-in with Google"),
                        backgroundColor: colorPalette.error,
                      ));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: colorPalette.background1,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: colorPalette.borderDefault ?? Colors.transparent,
                        width: 1),
                    borderRadius: BorderRadius.circular(spacing.radius2 ?? 0),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: spacing.padding2 ?? 0,
                      horizontal: spacing.padding5 ?? 0),
                  maximumSize: const Size(double.infinity, 42),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/google_logo.png'),
                    // Replace with your Google logo path
                    const SizedBox(width: 10),
                    Text(
                      'Continue with Google',
                      style: TextStyle(
                        color: colorPalette.textPrimary,
                        fontSize: typography.body?.medium?.fontSize,
                        fontFamily: typography.body?.medium?.fontFamily,
                        fontWeight: typography.body?.medium?.fontWeight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
