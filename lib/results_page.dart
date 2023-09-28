import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  static const id = 'results_page';

  const ResultsPage(tlvList, {super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return const Placeholder();
  }
}
