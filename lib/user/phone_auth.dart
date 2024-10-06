import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthPage extends StatefulWidget {
  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationId = '';

  // Send OTP to the entered phone number
  void verifyPhoneNumber() async {
    await auth.verifyPhoneNumber(
      phoneNumber: '+88${phoneController.text.trim()}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically sign in the user when OTP is auto-retrieved
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle error
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          this.verificationId = verificationId;
        });
        // Navigate to OTP input screen
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
    );
  }

  // Verify the OTP code entered by the user
  void verifyOtp() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otpController.text.trim(),
    );

    // Sign in with the provided credential
    await auth.signInWithCredential(credential).then((UserCredential userCredential) {
      // Successfully signed in
      log("Successfully signed in UID: ${userCredential.user?.uid}");
    }).catchError((e) {
      // Handle errors like wrong OTP
      log(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phone Authentication')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Enter Phone Number'),
            ),
            ElevatedButton(
              onPressed: verifyPhoneNumber,
              child: const Text('Send OTP'),
            ),
            TextField(
              controller: otpController,
              decoration: const InputDecoration(labelText: 'Enter OTP'),
            ),
            ElevatedButton(
              onPressed: verifyOtp,
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
