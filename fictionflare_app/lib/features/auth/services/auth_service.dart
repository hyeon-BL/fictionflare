import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  // Google Sign In
  signInWithGoogle() async {
    try {
      // begin interactive sign-in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // create a new credential for user
      final googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // finally, let's sign in
      return await FirebaseAuth.instance.signInWithCredential(googleCredential);
    } catch (e) {
      print(e);
    }
  }

  // Apple Sign In
  signInWithApple() async {
    try {
      // Trigger the Apple Sign In flow
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Create a new Firebase credential
      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Sign in the user with Firebase
      return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    }
    catch (e) {
      print(e);
    }
  }
}
