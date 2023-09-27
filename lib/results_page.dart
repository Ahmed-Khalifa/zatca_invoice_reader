import 'dart:convert';

import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  static const id = 'results_page';

  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(); // return ListView(children: texting(),);
  }

  List<Text> texting() {
    String textString =
        'R0lffnsL1p2GZJ8N34S4UQ6oe6THlK25YSNerGQe2SzCwp77yTRqtzn7bzD6ovz04SI+BH/DgBYnFNuhu9fo7g==';
    List<Text> textWidgets = [];
    textWidgets.add(Text('String: $textString'));

    Base64Decoder b64decoder = Base64Decoder();
    textWidgets
        .add(Text('Base64: ${b64decoder.convert(textString).toString()}'));

    return textWidgets;
  }
}
