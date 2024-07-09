import 'dart:html';

import 'package:bluebear/accountlink.dart';
import 'package:bluebear/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlueBear',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff38b6ff)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controllerA = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controllerA,
    curve: Curves.easeInExpo,
  );

  int _counter = 0;

  void resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  List<String> question = [
    'What\'s your name?',
    'What\'s your Major?',
    'At what school do you study?'
  ];
  List<String> hints = [
    'Fill out your name',
    'Fill out your major',
    'Fill out your School'
  ];
  bool accounts = false;
  TextEditingController _controller = TextEditingController();
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    _controllerA.forward();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Color(0xff38b6ff),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'bear.png',
                      height: Responsive.responsiveHeight(context, 0.1),
                      width: Responsive.responsiveWidth(context, 0.05),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'BlueBear',
                        style: GoogleFonts.roboto(
                            fontSize: 40, color: Colors.white),
                      ),
                    )
                  ]),
            ),
            Card(
              color: Colors.white,
              shadowColor: Colors.white,
              child: Container(
                  width: 700,
                  height: 700,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Hero(
                          tag: 'card2bg',
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FadeTransition(
                                  opacity: _animation,
                                  child: Text(
                                    question[_counter],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 40),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            key: UniqueKey(),
                            controller: _controller,
                            onSubmitted: (value) async {
                              setState(() {
                                _controller.value = TextEditingValue.empty;
                                _controllerA.reset();
                                _counter < 2 ? _counter++ : accounts = true;
                              });
                              if (accounts) {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (context, animation1, animation2) =>
                                            AccountLink(resetCounter),
                                  ),
                                );
                                if (FirebaseAuth.instance.currentUser == null)
                                  await FirebaseAuth.instance
                                      .signInAnonymously();
                              }
                            },
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: hints[_counter],
                              suffixIcon: Icon(Icons.send),
                            ),
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
//358d07ecc2ac636f8a1956ef7a4d30570936a8c26996986de335d73aff8afc70d3efb71ffb4380ec7732934a50350a38ab92534c