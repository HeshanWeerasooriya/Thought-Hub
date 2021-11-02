import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thought_hub/constants.dart';
import 'package:thought_hub/screens/signin_screen.dart';
import 'package:thought_hub/screens/thought_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = FirebaseAuth.instance;
  late UserCredential userCredential;

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _userEmail = '';
  String _userPassword = '';
  XFile? image;

  final ImagePicker picker = ImagePicker();

  void _pickImage() async {
    final XFile? pickedImageFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      image = pickedImageFile!;
    });
  }

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
    }

    try {
      setState(() {
        isLoading = true;
      });

      if (image != null) {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: _userEmail,
          password: _userPassword,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ThoughtScreen(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please pick an image'),
          ),
        );
      }

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(userCredential.user!.uid + '.jpg');

      await ref.putFile(File(image!.path));

      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'username': _userName.trim(),
        'email:': _userEmail.trim(),
        'image_url': url,
      });
    } on PlatformException catch (error) {
      var message = 'An error occurred, please check your credentials!';

      if (error.message != null) {
        message = error.message!;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );

      setState(() {
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
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
                          image == null
                              ? Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  child: ClipOval(
                                    child: Image.file(
                                      File(image!.path),
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                ),
                          TextButton.icon(
                            icon: const Icon(Icons.image),
                            label: const Text(
                              'Add Image',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: _pickImage,
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
                          if (isLoading) const CircularProgressIndicator(),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: _trySubmit,
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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
                    child: const Text('I already have an account'),
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
