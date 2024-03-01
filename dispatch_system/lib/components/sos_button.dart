import 'dart:convert';
import 'dart:io';
import 'package:dispatch_system/components/api.dart';
import 'package:dispatch_system/models/audioModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import '/utils/color.dart';
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:http/http.dart' as http;

class SOSButton extends StatefulWidget {
  final String? transcribe;
  const SOSButton({
    Key? key,
    required this.contacts,
    this.transcribe,
  }) : super(key: key);
  final List<String> contacts;

  @override
  _SOSButtonState createState() => _SOSButtonState();
}

class _SOSButtonState extends State<SOSButton> {
  late String transcibe = widget.transcribe ?? '';
  String audioPath = '';
  final cloudinary = Cloudinary.signedConfig(
    apiKey: dotenv.env['API_KEY']!,
    apiSecret: dotenv.env['API_SECRET']!,
    cloudName: dotenv.env['CLOUD_NAME']!,
  );
  final recorder = FlutterSoundRecorder();

  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  bool isClicked = false;
  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<void> requestPermissions() async {
    var status = await Permission.storage.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
  }

  Future startRecord() async {
    await recorder.startRecorder(toFile: 'temp.aac', codec: Codec.aacADTS);
  }

  Future stopRecorder() async {
    var headers = {
      'Content-type': 'multipart/form-data',
    };
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    print('Recorded file path: $filePath');
    print(file);
    final position = await _getCurrentLocation();
    final latitude = position.latitude.toString();
    final longitude = position.longitude.toString();
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://api2.asr.dodoozy.com/asr"));
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.transform(utf8.decoder).join();
      final responseData = jsonDecode(responseBody);
      print(responseBody);
      final result = audioresult.fromJson(responseData);
      transcibe = result.result ?? 'Help me urgent';
      API().sendwidget(transcibe);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FractionallySizedBox(
            widthFactor: 0.7,
            child: GestureDetector(
              onDoubleTap: () {
                _getCurrentLocationAndTrigger(widget.contacts);
              },
              onTap: () {
                if (recorder.isRecording) {
                  setState(() {
                    isClicked = false;
                  });
                  stopRecorder();
                } else {
                  startRecord();
                  setState(() {
                    isClicked = true;
                  });
                }
              },
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxWidth,
                margin: const EdgeInsets.only(bottom: 30, top: 30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isClicked ? Colors.green.withOpacity(0.8) : rSOS,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'SOS',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // final ACCESS_LOGIN =    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjkyMzczMTk2LCJpYXQiOjE2OTIxMTM5OTYsImp0aSI6ImZlY2UxMGUwMTkwOTQyMjM4ODE2YTJhOTNlZjFhYTE2IiwidXNlcl9pZCI6MjB9.PaAoJgTxfTPAM7wCCxsyI-4Cw_L4e6zQfIEVJtJYl8E";

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Fluttertoast.showToast(
              msg:
                  'Location permissions are permanently denied, we cannot request permission');
          return Future.error('Location permissions are permanently denied.');
        }
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> _getCurrentLocationAndTrigger(List<String> contacts) async {
    Fluttertoast.showToast(
      msg: 'SOS CALLED',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Position position;
    try {
      position = await _getCurrentLocation();
      final latitude = position.latitude.toString();
      final longitude = position.longitude.toString();
      // final ACCESS_LOGIN = await storage.read(key: 'access_login');
      // await getNearestUsers(ACCESS_LOGIN, latitude, longitude);
      String message = 'Jan Rakshak\n\n';
      message +=
          'Some one who added you to emergency Contact needs Help. !!\n\n';
      message += 'My current location is:\n';
      message += 'Latitude: ${position.latitude}\n';
      message += 'Longitude: ${position.longitude}\n';
      message += 'Click the following link to see my live location:\n';
      message +=
          'https://www.google.com/maps?q=${position.latitude},${position.longitude}';

      TwilioFlutter twilioFlutter = TwilioFlutter(
        accountSid: dotenv.env['TWILIO_ACCOUNT_SID']!,
        authToken: dotenv.env['TWILIO_AUTH_TOKEN']!,
        twilioNumber: dotenv.env['TWILIO_PHONE_NUMBER']!,
      );

      for (String contact in contacts) {
        try {
          await twilioFlutter.sendSMS(
            toNumber: contact,
            messageBody: message,
          );
          Fluttertoast.showToast(
            msg: 'Alert Sent',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print('SMS sent to $contact');
        } catch (e) {
          print('Failed to send SMS to $contact: $e');
          Fluttertoast.showToast(
            msg: 'Failed to send SMS to $contact',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } catch (e) {
      print("Some error occurred: $e");
      Fluttertoast.showToast(
        msg: 'Error getting location. Please try again.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    // Do something with the coordinates or send the location to the backend
    // print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
  }
}
