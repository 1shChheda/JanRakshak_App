import 'package:flutter/material.dart';
import '/components/emergency_button.dart';
import '../utils/color.dart';
import '/components/app_bar.dart';
import '/components/sos_button.dart';
import '/components/warrior_component.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({
    super.key,
  });

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  TextEditingController transcribeController = TextEditingController();
   String? transcribe = '';
  final List<String> contacts = ['+917045246557', '+919372630510'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarConstant(),
      body: Container(
        decoration: const BoxDecoration(
          color: rBackground,
          image: DecorationImage(
            image: AssetImage('assets/images/bgImage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Expanded(
                  //   flex: 1,
                  //   child: WarriorsBox(),
                  // ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            'Are you in a situation where you can not talk?',
                            style: TextStyle(
                                color: Colors.red[400],
                                fontWeight: FontWeight.bold),
                          ),
                          TextField( controller: transcribeController,
                          onEditingComplete: (){
                            transcribe=transcribeController.value.text;
                          },
                            decoration: InputDecoration(
                              hintText: 'Enter your message here',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  // Expanded(
                  //   flex: 1,
                  //   child: EFirFemaleComponent(),
                  // ),
                ],
              ),
            ),
            SOSButton(
              contacts: contacts,
            ),
            EmergencyButton(contacts: contacts),
          ],
        ),
      ),
    );
  }
}
