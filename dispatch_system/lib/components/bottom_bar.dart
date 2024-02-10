import 'package:flutter/material.dart';
import '../screens/details_page.dart';
import '../screens/fake_call_screen.dart';
import '../screens/home_screen.dart';
import '../screens/near_me_screen.dart';
import '../screens/safe_nav_screen.dart';
import '/utils/color.dart';

class BottomPage extends StatefulWidget {
  // final FlutterSecureStorage storage;
  const BottomPage({
    super.key,
  });

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  // FlutterSecureStorage get storage => widget.storage;
  int currentIndex = 0;

  List<Widget> pages = <Widget>[
    const NearMeScreen(),
    const SafeNavScreen(),
    const StartScreen(),
    const FakeCallScreen(),
    const DetailsPage(),
    //const BlogScreen()
  ];
  @override
  void initState() {
    super.initState();
  }

  onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTapped,
        elevation: 8.0,
        showSelectedLabels: true,
        selectedItemColor: rOrange,
        unselectedItemColor: rUnselectedItemColor,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        items: const [
          BottomNavigationBarItem(
            label: "Near Me",
            icon: Icon(Icons.near_me),
            backgroundColor: rBottomBar,
          ),
          BottomNavigationBarItem(
            label: "SafeNav",
            icon: Icon(Icons.location_on),
            backgroundColor: rBottomBar,
          ),
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.space_dashboard_rounded),
            backgroundColor: rBottomBar,
          ),
          BottomNavigationBarItem(
            label: "Fake Call",
            icon: Icon(Icons.call),
            backgroundColor: rBottomBar,
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
            backgroundColor: rBottomBar,
          ),
        ],
      ),
    );
  }
}
