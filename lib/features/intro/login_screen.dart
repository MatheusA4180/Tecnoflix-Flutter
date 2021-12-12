import 'package:flutter/material.dart';
import 'package:tecnoflix/features/home/home_nav_host.dart';
import 'package:tecnoflix/features/search/firebase_authentication.dart';

class LoginScreen extends StatelessWidget {
  final textEmailEditText = TextEditingController();
  final textPasswordEditText = TextEditingController();

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
                height: 50.0,
                margin:
                    const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
                child: TextField(
                  controller: textEmailEditText,
                  cursorColor: const Color.fromARGB(255, 255, 22, 22),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
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
                height: 50.0,
                margin:
                    const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
                child: TextField(
                  obscureText: true,
                  controller: textPasswordEditText,
                  cursorColor: const Color.fromARGB(255, 255, 22, 22),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color.fromARGB(255, 255, 22, 22),
                      ),
                    ),
                    labelText: 'Senha',
                    labelStyle: TextStyle(
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
                          top: 80.0, left: 60.0, right: 60.0),
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
                          if (auth(textEmailEditText.text,
                              textPasswordEditText.text)) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        (const HomeNavHost())));
                          } else {}
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
                          top: 20.0, left: 60.0, right: 60.0),
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
                            const Color.fromARGB(255, 255, 22, 22),
                          ),
                        ),
                        onPressed: () => registration(),
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
