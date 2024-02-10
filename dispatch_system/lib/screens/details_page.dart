import 'package:dispatch_system/components/pin_input.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(children: [
        TextField(
          controller: _phonecontroller,
          decoration:const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter your phone number',
          ),
        ),
        TextButton(onPressed: (){}, child: Text('Send OTP')),
        PinputExample(phoneNumber: _phonecontroller.text),
        
      ],),
    );
  }
}