import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tapcounter/app_route.gr.dart';
import 'package:tapcounter/features/counter/cubit/tap_cubit.dart';
import 'package:tapcounter/features/counter/data/models/tap_session_model.dart';

@RoutePage()
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance History'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.router.push(TapViewRoute()),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteSession();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<TapSession>('tap_sessions').listenable(),
        builder: (context, Box<TapSession> box, _) {
          final sessionHistory = box.values.toList().reversed.toList();
          if (sessionHistory.isEmpty) {
            return const Center(child: Text('No history yet.'));
          }
          return ListView.separated(
            itemBuilder: (_, index) {
              final totalItems = sessionHistory[index];
              return ListTile(
                title: Text('TotalTaps: ${totalItems.totalTaps}'),
                subtitle: Text(
                  'Time: ${totalItems.totalTime}Seconds, ---> Date:${totalItems.dateTime}',
                ),
              );
            },
            separatorBuilder: (_, __) => const Divider(),
            itemCount: sessionHistory.length,
          );
        },
      ),
    );
  }
}
