import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showSpinner = false;


  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(20, 23, 36, 100),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 23, 36, 100),
        title: const Text('Sign in to your Account',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('EMAIL',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              controller: _emailController,
              textAlign: TextAlign.left,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text('PASSWORD',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              controller: _passwordController,
              textAlign: TextAlign.left,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            ),

            Padding(padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Material(
                  elevation: 5.0,
                  color: Color.fromRGBO(35, 95, 227, 100),
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () async{
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        UserCredential userCredential = await auth.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        user = userCredential.user;
                        if(user != null)
                        {
                          Navigator.pushNamed(context, "profile");
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      }
                      on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided.');
                        }
                      }
                      catch(e)
                      {
                        print(e);
                      }


                    },
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 150.0),
                    height: 42.0,
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
            ),
            const SizedBox(
              height: 8.0,
            ),
            InkWell(
                child: const Text(
                'CREATE ACCOUNT',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'register');
              },
            ),
          ],
        ),
      ),
    );
  }
}