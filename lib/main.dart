import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart' show DefaultFirebaseOptions;
import 'pages/home_page.dart';
import 'pages/datos_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invernadero',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
 int _selectedPageIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _selectPage(int index) {
    Navigator.pop(context); // cierra el Drawer
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [HomePage(), DatosPage()];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 73, 129),
        title: Text('Invernadero', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 5, 73, 129)),
              child: Text(
                'Menú',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(title: Text('Home'), onTap: () => _selectPage(0)),
            ListTile(title: Text('Datos'), onTap: () => _selectPage(1)),
          ],
        ),
      ),
      body: pages[_selectedPageIndex],
    );
  }
}
