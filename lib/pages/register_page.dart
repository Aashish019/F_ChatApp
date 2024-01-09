import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emcontroller = TextEditingController();
  final TextEditingController pwcontroller = TextEditingController();
  final TextEditingController cpwcontroller = TextEditingController();
  final void Function()? onTap;
  RegisterPage({super.key, this.onTap});

  void register(BuildContext context) async {
    //getting auth service
    final auth = AuthService();
    //checking password and login
    if (pwcontroller.text == cpwcontroller.text) {
      try {
        auth.signUpWithEmailPassword(emcontroller.text, pwcontroller.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Password Don't match")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Let create an account for you",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 25,
            ),
            MyTextfield(
              hintText: "Email",
              obscureText: false,
              controller: emcontroller,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextfield(
              hintText: "Password",
              obscureText: true,
              controller: pwcontroller,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextfield(
              hintText: "Confirm Password",
              obscureText: true,
              controller: cpwcontroller,
            ),
            const SizedBox(
              height: 25,
            ),
            Mybutton(
              btnname: "Register",
              onTap: () => register(context),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    " Login Now",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
