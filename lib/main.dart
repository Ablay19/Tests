import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  // Initial position for the draggable box
  double _left = 100;
  double _bottom = 100;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('You have pushed the button this many times:'),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 20),
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey[200],
            child: Stack(
              children: [
                Positioned(
                  left: _left,
                  bottom: _bottom,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        final screenWidth = MediaQuery.of(context).size.width;
                        final screenHeight = 300; // Container height
                        // Box size
                        const boxSize = 150;
                        // Update position with boundary check
                        _left = (_left + details.delta.dx).clamp(
                          0.0,
                          screenWidth - boxSize,
                        );
                        _bottom = (_bottom - details.delta.dy).clamp(
                          0.0,
                          screenHeight - boxSize,
                        );
                      });
                    },
                    child: AnimatedContainer(
                      color: Colors.red,
                      height: 150,
                      width: 150,
                      duration: const Duration(seconds: 1),
                      child: const Center(
                        child: Text(
                          'Drag Me',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
