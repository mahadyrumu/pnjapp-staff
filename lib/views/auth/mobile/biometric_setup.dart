import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jetdispatch/views/home/home.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BiometricSetup extends StatefulWidget {
  const BiometricSetup({Key? key}) : super(key: key);

  @override
  State<BiometricSetup> createState() => _BiometricSetupState();
}

class _BiometricSetupState extends State<BiometricSetup> {
  late LocalAuthentication auth = LocalAuthentication();
  int? authState;
  late String biometricType = '';
  Future<void> _biometricAuth() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Biometric Auth',
          options: const AuthenticationOptions(
            stickyAuth: true,
            biometricOnly: true,
          ));
      if (authenticated) {
        writeLocalAuthData();
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

  readLocalAuthData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      authState = prefs.getInt('state');
    });
    return authState;
  }

  writeLocalAuthData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('state', 1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readLocalAuthData();
  }

  @override
  Widget build(BuildContext context) {
    _getAvailableBiometrics();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(
                    biometricType == "BiometricType.face"
                        ? Icons.face_unlock_sharp
                        : Icons.fingerprint,
                    size: 90,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  "Sign in faster!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  biometricType == "BiometricType.face"
                      ? "Set up face id"
                      : "Set up fingerprint",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              textStyle: MaterialStateProperty.all(
                                  const TextStyle(
                                      fontSize: 18, color: Colors.white))),
                          onPressed: () {
                            _getAvailableBiometrics();
                            _biometricAuth();
                          },
                          child: const Text(
                            'Next',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          textStyle: MaterialStateProperty.all(const TextStyle(
                              fontSize: 18, color: Colors.white))),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      },
                      child: const Text(
                        'Not now',
                        style: TextStyle(color: Colors.blue),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
