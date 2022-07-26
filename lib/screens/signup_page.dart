import 'package:flutter/material.dart';
import 'package:login_and_register/screens/signin_page.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isChecked = false;
  Future<String> _authUserSignUp(
      String email, String password, String firstName, String lastName) async {
    return Future.delayed(Duration.zero).then((_) async {
      try {
        await Provider.of<Auth>(context, listen: false)
            .signUp(email, password, firstName, lastName);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sign up successful!'),
          backgroundColor: Colors.green,
        ));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
      return "/";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 30, 95, 225),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      color: const Color.fromARGB(255, 236, 246, 255),
                      width: 300,
                      height: 660,
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 30.0, right: 30.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Create your Account",
                              style: TextStyle(
                                  fontSize: 21.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 25.0),
                            const Text(
                              "First Name",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              width: 250,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input your first name';
                                  }
                                  return null;
                                },
                                controller: firstNameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "First Name",
                                    hintText: "e.g. John"),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              "Last Name",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              width: 250,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input your last name';
                                  }
                                  return null;
                                },
                                controller: lastNameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Last Name",
                                    hintText: "e.g. Doe"),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              "Email Address",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              width: 250,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please input your email address';
                                  }
                                  return null;
                                },
                                controller: emailController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Email Address",
                                    hintText: "email@example.org"),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10.0),
                            SizedBox(
                              width: 250,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Password",
                                    hintText: "********"),
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                const Expanded(
                                  child: Text(
                                    "To register with us please tick to agree to our Terms and Conditions.",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromARGB(255, 0, 104, 200),
                                  minimumSize: const Size(250, 50)),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );
                                }
                                _authUserSignUp(
                                    emailController.text,
                                    passwordController.text,
                                    firstNameController.text,
                                    lastNameController.text);
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 221, 221, 221)),
                        ),
                        SizedBox(
                          height: 32.0,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInPage(),
                                  ));
                            },
                            child: const Text(
                              "Sign In",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
