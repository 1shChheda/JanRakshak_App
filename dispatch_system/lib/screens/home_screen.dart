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
            const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: WarriorsBox(),
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
