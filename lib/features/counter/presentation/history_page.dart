import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: Text('Performance History')),
      body: ListView.separated(
        itemBuilder: itemBuilder,
        separatorBuilder: separatorBuilder,
        itemCount: itemCount,
      ),
      
    );
  }
}
