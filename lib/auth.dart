import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/sign_in.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signUptoFirebase() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("sign up success")));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
                hintText: ('write email'), labelText: 'Email'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
                hintText: ('write password'), labelText: 'password'),
          ),
          ElevatedButton(
              onPressed: () {
                signUptoFirebase();
              },
              child: const Text('sign up')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SigninPage(),
                  ),
                );
              },
              child: const Text('Sign in')),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyhomePage(),
                    ));
              },
              child: Text('to do'))
        ],
      ),
    );
  }
}
