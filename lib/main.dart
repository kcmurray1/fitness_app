import 'package:flutter/material.dart';
import 'package:fitness_app/pages/map_page/map.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/pages/timer_page/timer_page.dart';
import 'package:fitness_app/models/interval_timer.dart';
import 'package:fitness_app/pages/timer_select_page/timer_select_page.dart';

void main() {
  runApp(const MyApp());
}

enum Page {
  map,
  timerSelection,
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => IntervalTimer(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 59, 126, 228)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Timer Home Page'),
      )
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

class _MyHomePageState extends State<MyHomePage> {
  
  Page pageIndex = Page.timerSelection;
  bool displayMenu = false;
  @override
  Widget build(BuildContext context) {
    
    Widget page;

    switch(pageIndex)
    {
      // case Page.timer:
      //   page = TimerPage();
      case Page.map:
        page = MapPage();
      case Page.timerSelection:
        page = TimerSelectPage();
      default:
        throw UnimplementedError("No widget for index $pageIndex");  
    }

    return LayoutBuilder(
      builder: (context, constraints){
        return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Theme.of(context).colorScheme.primary,
            statusBarColor: Theme.of(context).colorScheme.primary
          ),
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "Fit App",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)
            )
          ),
          leading: IconButton(
            icon: Icon(displayMenu ? Icons.close : Icons.menu),
            onPressed: () {
              setState(() {
                // Toggle menu visibility
                displayMenu = !displayMenu; 
              });
            },
          ),
        ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: page
            ),
          ),
        if (displayMenu)
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            child: SafeArea(
                child: NavigationRail(
                  backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
                  extended: constraints.maxWidth >= 400,
                  destinations: [
                    // NavigationRailDestination(
                    //   icon: Icon(Icons.access_time_outlined), 
                    //   label: Text(
                    //     "Timer",
                    //     style: TextStyle(fontSize: 20)
                    //   ),
                    // ),
                    NavigationRailDestination(
                      icon: Icon(Icons.map), 
                      label: Text(
                        "Map",
                        style: TextStyle(fontSize: 20),
                      )
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.abc), 
                      label: Text(
                        "test",
                        style: TextStyle(fontSize: 20),
                      )
                    )
                  ], 
                  selectedIndex: pageIndex.index,
                  onDestinationSelected: (value)
                  {
                    setState(() {
                      pageIndex = Page.values[value];
                    });
                  },
                ),
              ),
            )
          ]   
        )
      );
    });
  }
}

