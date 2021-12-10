import 'package:flutter/material.dart';
import 'package:tecnoflix/features/search/firebase_authentication.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80.0),
              child: Image.asset('assets/image/tecnoflix_logo.png'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
              child: const TextField(
                //obscureText: true,
                //controller: textEditText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Text Input',
                  fillColor: Colors.white,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
              child: const TextField(
                //obscureText: true,
                //controller: textEditText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Text Input',
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
                        top:80.0, left: 60.0, right: 60.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                  side: const BorderSide(color: Color.fromARGB(255, 255, 22, 22),)
                              )
                          ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.only(top: 15.0,bottom: 15.0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 255, 22, 22),
                        ),
                      ),
                      onPressed: () => registration(),
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
                        top:20.0, left: 60.0, right: 60.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                                side: const BorderSide(color: Color.fromARGB(255, 255, 22, 22),)
                            )
                        ),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.only(top: 15.0,bottom: 15.0),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 255, 22, 22),
                        ),
                      ),
                      onPressed: () => auth(),
                      child: const Text("CADASTRAR"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
