import 'package:flutter/material.dart';
import 'package:tecnoflix/data/remote/firebase_authentication.dart';
import 'package:tecnoflix/features/home/home_nav_host.dart';
import 'package:tecnoflix/features/intro/resgistration_screen.dart';
import 'package:tecnoflix/model/resource.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final textEmailEditText = TextEditingController();
  final textPasswordEditText = TextEditingController();
  bool _isHidden = true;

  navigationToHome(Resource value, BuildContext context) {
    if (value.result) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => (const HomeNavHost())));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value.descriptionError)));
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 120.0),
                child: Image.asset('assets/image/tecnoflix_logo.png'),
              ),
              Container(
                height: 56.0,
                margin:
                    const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
                child: TextField(
                  controller: textEmailEditText,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      //borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 255, 22, 22),
                      ),
                    ),
                    labelText: 'E-mail',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 255, 22, 22),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Container(
                height: 56.0,
                margin:
                    const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
                child: TextField(
                  obscureText: _isHidden,
                  controller: textPasswordEditText,
                  decoration: InputDecoration(
                    suffix: InkWell(
                      onTap: _togglePasswordView,
                      child: Icon(
                        _isHidden ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      //borderRadius: BorderRadius.all(Radius.circular(0)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 255, 22, 22),
                      ),
                    ),
                    labelText: 'Senha',
                    labelStyle: const TextStyle(
                      color: Color.fromARGB(255, 255, 22, 22),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 60.0, left: 60.0, right: 60.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 255, 22, 22),
                              ),
                            ),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 255, 22, 22),
                          ),
                        ),
                        onPressed: () {
                          var response = auth(textEmailEditText.text,
                              textPasswordEditText.text);
                          response.then(
                              (value) => navigationToHome(value, context)
                          );
                        },
                        child: const Text("ENTRAR"),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 32.0, left: 60.0, right: 60.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24.0),
                                      side: const BorderSide(
                                        color: Color.fromARGB(255, 255, 22, 22),
                                      ))),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.black //Color.fromARGB(255, 255, 22, 22),
                              ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      (RegistrationScreen())));
                        },
                        child: const Text("CADASTRAR"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
