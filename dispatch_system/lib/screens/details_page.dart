import 'package:dispatch_system/components/pin_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../components/bottom_bar.dart';
import 'emergency_contacts.dart';

final TextEditingController _phonecontroller = TextEditingController();

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    final String verificationId = '';
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _phonecontroller,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Enter your phone number',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 150,
                  child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          verificationCompleted:
                              (PhoneAuthCredential credentials) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            FocusScope.of(context).nextFocus(); //
                            setState(() {
                              verificationId = verificationId;
                            });
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                          phoneNumber: _phonecontroller.text.toString(),
                        );
                      },
                      child: Text('Send OTP')),
                ),
                SizedBox(
                  height: 20,
                ),
                PinputExample(
                  verificationId: verificationId,
                  //  phone: _phonecontroller.text,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PinputExample extends StatefulWidget {
  String? verificationId;
  PinputExample({Key? key, this.verificationId}) : super(key: key);

  @override
  State<PinputExample> createState() => _PinputExampleState();
}

class _PinputExampleState extends State<PinputExample> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Heylo at ');
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            // Specify direction if desired
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 6,
              controller: pinController,
              focusNode: focusNode,
              androidSmsAutofillMethod:
                  AndroidSmsAutofillMethod.smsUserConsentApi,
              listenForMultipleSmsOnAndroid: true,
              defaultPinTheme: defaultPinTheme,
              separatorBuilder: (index) => const SizedBox(width: 8),
              hapticFeedbackType: HapticFeedbackType.lightImpact,
              onCompleted: (pin) {
                // debugPrint('onCompleted: $pin');
              },
              onChanged: (value) {
                // debugPrint('onChanged: $value');
              },
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: focusedBorderColor,
                  ),
                ],
              ),
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: fillColor,
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: focusedBorderColor),
                ),
              ),
              errorPinTheme: defaultPinTheme.copyBorderWith(
                border: Border.all(color: Colors.redAccent),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              height: 45,
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  focusNode
                      .unfocus(); // Ensure focus is removed from the PIN field

                  if (formKey.currentState!.validate()) {
                    // Validate the form

                    final enteredOtp = pinController.text;
                    final response;
                    try {
                      PhoneAuthCredential credentials =
                          PhoneAuthProvider.credential(
                              verificationId: widget.verificationId ?? '',
                              smsCode: enteredOtp);
                      FirebaseAuth.instance
                          .signInWithCredential(credentials)
                          .then((value) => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => BottomPage())));
                    } catch (e) {
                      print(e);
                    }
                    final String phone = _phonecontroller.text;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmergencyContactScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid OTP')),
                    );
                  }
                },
                child: const Text(
                  "Continue",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
