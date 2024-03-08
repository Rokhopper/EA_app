import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showSpinner = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 23, 36, 100),
      appBar: AppBar(
        title: const Text(
          'Create your Account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(20, 23, 36, 100),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                padding:  const EdgeInsets.all(40.0),
                child: Container(
                  child: const Image(
                    image: NetworkImage('https://media.contentapi.ea.com/content/dam/eacom/common/medallion-violet.png'),
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: _nameController,
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Enter Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),

            const SizedBox(
              height: 8.0,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextFormField(
                controller: _emailController,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Enter Email',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 8.0,
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                controller: _passwordController,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.white),
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter Password',
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
                  color: const Color.fromRGBO(110, 52, 235, 100),
                  borderRadius: BorderRadius.circular(10.0),
                  child: MaterialButton(
                    onPressed: () async{
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                        UserCredential userCredential = await auth.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        user = userCredential.user;
                        await user!.updateDisplayName(_nameController.text);
                        await user!.reload();
                        user = auth.currentUser;
                        if (user != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }
                        setState(() {
                          showSpinner = false;
                        });
                      }
                      on FirebaseAuthException catch(e)
                      {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      }
                      catch(e)
                      {
                        print(e);
                      }

                    },
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 143.0),
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'REGISTER',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}