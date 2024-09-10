import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';



class AuthController extends GetxController {
  static AuthController instance = Get.find();

  var phoneAuthCredential = Rxn<PhoneAuthCredential>();
  var verificationId = ''.obs;
  var isLoading = false.obs;
  var authStatus = ''.obs;

  FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to format the phone number
  String formatPhoneNumber(String phoneNumber) {
    if (!phoneNumber.startsWith('+')) {
      // Assuming the default country code is +91 (India)
      phoneNumber = '+91' + phoneNumber;
    }
    return phoneNumber;
  }

  // Function to send OTP
  Future<void> sendOTP(String phoneNumber) async {
    isLoading(true);
    phoneNumber = formatPhoneNumber(phoneNumber); // Ensure the phone number format
    print("Sending OTP to: $phoneNumber"); // Debugging print statement

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // This callback is used when auto-verification succeeds
          phoneAuthCredential.value = credential;
          await _auth.signInWithCredential(credential);
          authStatus.value = "User signed in automatically.";
          print(authStatus.value); // Debugging print
        },
        verificationFailed: (FirebaseAuthException e) {
          // This callback is used when verification fails
          authStatus.value = "Verification failed. Error: ${e.code}, message: ${e.message}";
          print(authStatus.value); // Debugging print
        },
        codeSent: (String verificationId, int? resendToken) {
          // This callback is used when OTP is sent successfully
          this.verificationId.value = verificationId;
          debugPrint(verificationId);
          authStatus.value = "OTP sent successfully.";
          print(authStatus.value); // Debugging print
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // This callback is used when the auto-retrieval timeout occurs
          this.verificationId.value = verificationId;
          authStatus.value = "Code auto-retrieval timeout. Please enter OTP manually.";
          print(authStatus.value); // Debugging print
        },
      );
    } catch (e) {
      authStatus.value = "Error sending OTP. Error: $e";
      print(authStatus.value); // Debugging print
    } finally {
      isLoading(false);
    }
  }

  // Function to verify OTP
  Future<void> verifyOTP(String smsCode) async {
    isLoading(true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      authStatus.value = "User signed in successfully.";
      print(authStatus.value); // Debugging print
    } catch (e) {
      authStatus.value = "OTP verification failed. Error: $e";
      print(authStatus.value); // Debugging print
    } finally {
      isLoading(false);
    }
  }

  // Check if user is signed in or not
  Stream<User?> get user => _auth.authStateChanges();

  // Sign out function
  Future<void> signOut() async {
    await _auth.signOut();
    authStatus.value = "Signed out.";
    print(authStatus.value); // Debugging print
  }
}
