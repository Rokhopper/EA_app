import 'package:flutter/material.dart';
import 'profile_page.dart';

void main() => runApp(const MainPage());

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Games',
      style: optionStyle,
    ),
    Text(
      'Index 2: EA_Play',
      style: optionStyle,
    ),
    Text(
      'Index 3: Favorite'
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(20, 23, 36, 100),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(20, 23, 36, 100),
        title: const Text('RRG_Wiki',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                  ),
                );
              },
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'News',
            backgroundColor: Color.fromRGBO(20, 23, 36, 100),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Games',
            backgroundColor: Color.fromRGBO(20, 23, 36, 100),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business_sharp),
            label: 'EA_Play',
            backgroundColor: Color.fromRGBO(20, 23, 36, 100),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
            backgroundColor: Color.fromRGBO(20, 23, 36, 100),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(170, 110, 255, 100),
        onTap: _onItemTapped,
      ),
    );
  }
}

