import 'package:flutter/material.dart';
import 'package:login_and_register/screens/signup_page.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);
  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<String> _authUserSignIn(String email, String password) async {
    return Future.delayed(Duration.zero).then((_) async {
      try {
        await Provider.of<Auth>(context, listen: false).signIn(email, password);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Sign in successful!'),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    color: const Color.fromARGB(255, 236, 246, 255),
                    width: 300,
                    height: 400,
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 30.0, right: 30.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login to your Account",
                            style: TextStyle(
                                fontSize: 21.0, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 25.0),
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
                                  return 'Please input your email';
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please input your password';
                                }
                                return null;
                              },
                              controller: passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Password",
                                  hintText: "********"),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromARGB(255, 0, 104, 200),
                                minimumSize: const Size(250, 50)),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                              _authUserSignIn(
                                emailController.text,
                                passwordController.text,
                              );
                              //show snackbar when return error
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
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
                                      builder: (context) => const SignUpPage(),
                                    ));
                              },
                              child: const Text(
                                "Register",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Forgotten your password?",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromARGB(255, 221, 221, 221)),
                          ),
                          SizedBox(
                            height: 32.0,
                            child: TextButton(
                              onPressed: null,
                              child: Text(
                                "Recover Password",
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
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
