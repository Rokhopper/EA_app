import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'main_page.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class ProfilePage extends StatefulWidget {

  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  SampleItem? selectedItem;

  @override
  void initState() {
    super.initState();
    if(auth.currentUser!=null)
    {
      user = auth.currentUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 23, 36, 100),
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(20, 23, 36, 100),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<SampleItem>(
              initialValue: selectedItem,
              onSelected: (SampleItem item) {
                setState(() {
                  selectedItem = item;
                });
              },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: ListTile(
                leading: const Icon(Icons.login),
                title: const Text('Login'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
            ),
            const PopupMenuItem<SampleItem>(
              value: SampleItem.itemTwo,
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ),
              PopupMenuItem<SampleItem>(
                value: SampleItem.itemThree,
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async{
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 250.0,
            ),
            Text(
              '${user?.displayName}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                ),
            ),
          ],
        ),
      ),
    );
  }
}