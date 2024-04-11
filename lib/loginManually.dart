import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shift_client/api.dart';
import 'package:shift_client/main.dart';

class LoginManuallyPage extends StatefulWidget {
  const LoginManuallyPage({super.key});

  @override
  State<LoginManuallyPage> createState() => _LoginManuallyPageState();
}

class _LoginManuallyPageState extends State<LoginManuallyPage> {
  TextEditingController _token = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _token,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(
                onPressed: () async {
                  print(_token);
                  await login(_token.text).then((value) {
                    if (value == true) {
                      print(value);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        dispose();

                        return MyHome();
                      }));
                    }
                  });
                },
                child: Text("Войти"))
          ],
        ),
      ),
    );
  }
}
