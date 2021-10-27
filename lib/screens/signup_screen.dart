import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thought_hub/constants.dart';
import 'package:thought_hub/screens/signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  late UserCredential userCredential;

  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
    }
    userCredential = await _auth.createUserWithEmailAndPassword(
      email: _userEmail,
      password: _userPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                          ),
                          TextButton.icon(
                            icon: Icon(Icons.image),
                            label: Text('Add Image'),
                            onPressed: () {},
                          ),
                          const SizedBox(
                            height: defaultPadding * 2,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'userame',
                            ),
                            validator: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                return 'Please enter at least 4 characers';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userName = value!;
                            },
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email address',
                            ),
                            onSaved: (value) {
                              _userEmail = value!;
                            },
                          ),
                          const SizedBox(
                            height: defaultPadding,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Password must be least at 7 characers long';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Password',
                            ),
                            obscureText: true,
                            onSaved: (value) {
                              _userPassword = value!;
                            },
                          ),
                          const SizedBox(
                            height: defaultPadding * 2,
                          ),
                          ElevatedButton(
                            onPressed: _trySubmit,
                            child: Text('Sign up'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SigninScreen(),
                        ),
                      );
                    },
                    child: Text('I already have an account'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
