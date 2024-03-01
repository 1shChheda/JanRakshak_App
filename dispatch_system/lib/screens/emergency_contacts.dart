import 'package:dispatch_system/components/bottom_bar.dart';
import 'package:dispatch_system/models/addUserModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/api.dart';

class EmergencyContactScreen extends StatelessWidget {
  EmergencyContactScreen({
    super.key,
  });
  TextEditingController phone = TextEditingController();
  TextEditingController emecon1 = TextEditingController();

  TextEditingController emecon2 = TextEditingController();

  TextEditingController name = TextEditingController();
  Future<void> storeUserUid(uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userUid', uid);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: phone,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Enter your phone number',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: emecon1,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Emergency Contact 1',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Enter the number of the contact',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: emecon2,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Emergency Contact 2',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Enter the number of the contact',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                    onPressed: () async {
                      print(emecon1.text);
                      print(emecon2.text);
                      final user = await API().addUser(
                        name.value.text,
                        phone.value.text,
                        emecon1.value.text,
                        emecon2.value.text,
                      );
                      print(user?.user?.sId ?? '');
                      final String uid = user?.user?.sId ?? '';
                      storeUserUid(uid);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BottomPage()));
                    },
                    child: Text('Save')),
              )
            ],
          ),
        ),
      )),
    );
  }
}
