import 'package:fictionflare_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  Future<void> sendSignInEmailLink(String email) async {
    try {
      var acs = ActionCodeSettings(
        url: 'https://fictionflareapp.page.link/welcome',
        handleCodeInApp: true,
        iOSBundleId: 'your.ios.bundle.id',
        androidPackageName: 'your.android.package.name',
        androidInstallApp: true,
        androidMinimumVersion: '12',
      );

      await auth.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: acs,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<UserCredential> signInWithEmailLink({
    required String email,
    required String emailLink,
    required BuildContext context,
  }) async {
    try {
      if (!auth.isSignInWithEmailLink(emailLink)) {
        throw Exception('Invalid email link');
      }

      final userCredential = await auth.signInWithEmailLink(
        email: email,
        emailLink: emailLink,
      );
      
      return userCredential;


    } on FirebaseAuthException catch (e) {
      showSnackbar(context: context, message: e.toString());
      throw Exception('Failed to sign in with email link');
    }
  }
}