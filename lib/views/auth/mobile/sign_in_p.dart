import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:jetdispatch/views/auth/mobile/biometric_setup.dart';
import 'package:jetdispatch/views/home/home.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInP extends StatefulWidget {
  const SignInP({Key? key}) : super(key: key);

  @override
  State<SignInP> createState() => _SignInPState();
}

class _SignInPState extends State<SignInP> {
  late LocalAuthentication auth = LocalAuthentication();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> _lotNo = ['Lot 1', 'Lot 2', 'Lot 3', 'Lot 4'];
  final List<String> _role = [
    'Office',
    'Van_11',
    'Van_12',
    'Van_13',
    'Van_14',
    'Van_15',
    'Van_21',
    'Van_22',
    'Van_23',
    'Van_24',
    'Van_25',
  ];

  String _lotNoValue = 'Lot 1';
  String _roleValue = 'Office';
  int? authState;
  late bool isBioSupported;
  late String biometricType = '';

  _signIn() async {
    var data = {
      'username': _userNameController.text,
      'password': _passwordController.text,
      'uuid': 'undefined',
      'roleConstantKey': _roleValue,
      'appVersion': 'Prod.1.3.3 Beta',
      'deviceVersion': 'undefined',
    };

    // var res = CallApi().signIn(data, 'login');
    var res = await http.post(
        Uri.parse("http://prodlot2.parknjetseatac.com:9000/dispatcher/login"),
        body: data);
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_data', jsonEncode(body['data']));
      if (isBioSupported) {
        // ignore: use_build_context_synchronously
        if (authState != 1) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const BiometricSetup()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Center(child: Text('WARNING!')),
          content: const Text('Sign in failed, Invalid credential'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  readLocalAuthData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    authState = prefs.getInt('state');
    return authState;
  }

  writeLocalAuthData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('state', 1);
  }

  Future<void> _biometricAuth() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Biometric Auth',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));
      if (authenticated) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        // print("Biometric not matched");
      }
      // print("Authenticated : $authenticated");
    } on PlatformException catch (e) {
      // print(e);
    }
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();
    if (availableBiometrics.isNotEmpty) {
      biometricType = availableBiometrics[0].toString();
    }
    // print("List of available Biometrics : $availableBiometrics");
    if (!mounted) {
      return;
    }
  }

  biometricAuth() {
    readLocalAuthData();
    if (authState == 1) {
      _getAvailableBiometrics();
      _biometricAuth();
    }
  }

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(newMethod);
  }

  FutureOr<Null> newMethod(bool isSupported) {
    setState(() {
      isBioSupported = isSupported;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getAvailableBiometrics();
    biometricAuth();
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/sign_in/back.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.fromLTRB(40, 250, 40, 200),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              value: _lotNoValue,
                              items: _lotNo.map((String lotNo) {
                                return DropdownMenuItem(
                                    value: lotNo, child: Text(lotNo));
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _lotNoValue = newValue!;
                                });
                              }),
                        ),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              value: _roleValue,
                              items: _role.map((String role) {
                                return DropdownMenuItem(
                                    value: role, child: Text(role));
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _roleValue = newValue!;
                                });
                              }),
                        ),
                      )
                    ],
                  )),
              // ElevatedButton
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.fromLTRB(95, 20, 95, 20)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontSize: 18, color: Colors.red))),
                    onPressed: () {
                      _signIn();
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              authState == 1
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.fromLTRB(60, 20, 60, 20)),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                      fontSize: 18, color: Colors.white))),
                          onPressed: () {
                            _getAvailableBiometrics();
                            _biometricAuth();
                          },
                          child: Text(
                            biometricType == "BiometricType.face"
                                ? 'Use Face Id'
                                : 'Use Fingerprint',
                            style: const TextStyle(color: Colors.red),
                          )),
                    )
                  : SizedBox(height: 50, child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
