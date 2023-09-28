import 'package:flutter/material.dart';
import 'package:zatca_invoice_reader/results_page.dart';
import 'package:zatca_invoice_reader/scanner_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZATCA Invoice Reader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ZATCA Invoice Reader'),
      routes: {
        ScannerPage.id: (context) => const ScannerPage(),
        ResultsPage.id: (context) => const ResultsPage(),
      },
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: IconButton.filledTonal(
                iconSize: MediaQuery.of(context).size.width / 2,
                onPressed: () => Navigator.pushNamed(context, ScannerPage.id),
                icon: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black38,
                    size: MediaQuery.of(context).size.width / 2,
                  ),
                ))));
  }
}
