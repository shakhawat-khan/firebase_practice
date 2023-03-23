import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void signIntoFirebase() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("sign up success")));
      setState(() {});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

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
          if (user == null)
            ElevatedButton(
              onPressed: () {
                signIntoFirebase();
              },
              child: Text('Sign In'),
            ),
          if (user != null)
            ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  setState(() {});
                },
                child: Text('Sign out')),
          if (user != null) Text("signed in" + user.email.toString())
        ],
      ),
    );
  }
}
