import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import 'call_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home_page',
      routes: {
        '/home_page': (context) => HomePage(),
        '/call_page': (context) => CallPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  // final int appID = 262329406;

  // // TODO Heroku server url for example
  // // Get the server from: https://github.com/ZEGOCLOUD/dynamic_token_server_nodejs
  // final String tokenServerUrl =
  //     'https//video-call-app-123.herokuapp.com/'; // https://xxx.herokuapp.com

  /// Check the permission or ask for the user if not grant
  ///
  /// TODO Copy to your project
  final Map<String, String> user1Args = {
    'userID': 'user1',
    'token':
        '04AAAAAGKklr8AEGl6MjFnNmoyY2RmbzR0NzUAoF+TqPu83tw+wClu4X+BjK6m2kJ9b/A6wvavBco3CEBJHtXMQlqrRIGWgNhnVeJKqbUucO9H6as6eQmZvSRyRNBlpsI0Cja/mhQ9jME5PCUl7LiFlX1iT3QKrLUPoEOpCRYsmKRVOb8iSRaMZcxG7od11a9mddecsNMjO8ZLtiQOkQtrVOKd4C6g5iFUKN/XMOd6rLBAHpo1dz7G4/4b+zU= '
  };
  final Map<String, String> user2Args = {
    'userID': 'user2',
    'token':
        '04AAAAAGKklwAAEGpmZnBkZTVkbmZzN2I1YzUAoEGfYq6pHp+AE180yNXRD8VwTb/FYkgCLP9dal91MqXeTYIivqh5tDDFk0P8s7s8dKgFHddlb6pMDoWHCSN/4HhPgHwOg9n7Nlu5m6D5TdU6OzG5+IneWra3dK7zECbrJqkW6KrqqcSm+r0HQPAAqepaYMA+WN9fi1MDYCLu4/HQ+Gzjbhy+eUp4kdnHJ1Sn30jWMOhp8alSqCFSy1cZ1gQ= '
  };

  Future<bool> requestPermission() async {
    PermissionStatus microphoneStatus = await Permission.microphone.request();
    if (microphoneStatus != PermissionStatus.granted) {
      log('Error: Microphone permission not granted!!!');
      return false;
    }
    PermissionStatus cameraStatus = await Permission.camera.request();
    if (cameraStatus != PermissionStatus.granted) {
      log('Error: Camera permission not granted!!!');
      return false;
    }
    return true;
  }

  /// Get the ZEGOCLOUD's API access token
  ///
  /// There are some API of ZEGOCLOUD need to pass the token to use.
  /// We use Heroku service for test.
  /// You can get your temporary token from ZEGOCLOUD Console [My Projects -> project's Edit -> Basic Configurations] : https://console.zegocloud.com/project  for both User1 and User2.
  /// Read more about the token: https://docs.zegocloud.com/article/14140
  // Future<String> getToken(String userID) async {
  //   final response =
  //       await http.get(Uri.parse('$tokenServerUrl/access_token?uid=$userID'));
  //   if (response.statusCode == 200) {
  //     final jsonObj = jsonDecode(response.body);
  //     return jsonObj['token'];
  //   } else {
  //     return "";
  //   }
  // }

  // /// Get the necessary arguments to join the room for start the talk or live streaming
  // ///
  // ///  TODO DO NOT use special characters for userID and roomID.
  // ///  We recommend only contain letters, numbers, and '_'.
  // Future<Map<String, String>> getJoinRoomArgs(String roomID) async {
  //   // final userID = math.Random().nextInt(10000).toString();
  //   final String token = await getToken('user1');
  //   return {
  //     'userID': 'user1',
  //     'token':
  //         '04AAAAAGKklr8AEGl6MjFnNmoyY2RmbzR0NzUAoF+TqPu83tw+wClu4X+BjK6m2kJ9b/A6wvavBco3CEBJHtXMQlqrRIGWgNhnVeJKqbUucO9H6as6eQmZvSRyRNBlpsI0Cja/mhQ9jME5PCUl7LiFlX1iT3QKrLUPoEOpCRYsmKRVOb8iSRaMZcxG7od11a9mddecsNMjO8ZLtiQOkQtrVOKd4C6g5iFUKN/XMOd6rLBAHpo1dz7G4/4b+zU=',
  //     'appID': '262329406',
  //   };
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () async {
              await requestPermission();
              Navigator.pushReplacementNamed(context, '/call_page',
                  arguments: user1Args);
            },
            child: const Text('Join as User 1'),
          ),
          TextButton(
            onPressed: () async {
              await requestPermission();
              Navigator.pushReplacementNamed(context, '/call_page',
                  arguments: user2Args);
            },
            child: const Text('Join as User 2'),
          )
        ],
      ),
    );
  }
}
