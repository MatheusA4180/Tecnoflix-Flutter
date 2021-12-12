import 'package:flutter/material.dart';
import 'package:tecnoflix/features/favorite/favorite_screen.dart';
import 'package:tecnoflix/features/search/search_screen.dart';
import 'home_screen.dart';

class HomeNavHost extends StatefulWidget {
  const HomeNavHost({Key? key}) : super(key: key);

  @override
  _HomeNavHost createState() => _HomeNavHost();
}

class _HomeNavHost extends State<HomeNavHost> {
  int _indiceAtual = 0;
  final List<Widget> _telas = [HomeScreen(), SearchScreen(), FavoriteScreen()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            leading: Image.asset('assets/image/tecnoflix_logo.png'),
            leadingWidth: 200.0,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            actions: [
              IconButton(
                icon: const Icon(Icons.cast),
                tooltip: 'Transmitir',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Transmitir a serie')));
                },
              ),
            ],
          ),
          body: _telas[_indiceAtual],
          backgroundColor: const Color.fromARGB(100, 51, 51, 51),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            unselectedItemColor: Colors.white,
            selectedItemColor: const Color.fromARGB(255, 255, 22, 22),
            currentIndex: _indiceAtual,
            onTap: onTabTapped,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), title: Text('Busca')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), title: Text('Favoritos')),
            ],
          ),
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }
}
