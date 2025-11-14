import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tapcounter/features/counter/data/models/tap_session_model.dart';
import 'package:tapcounter/features/userprofile/data/models/user_model.dart';

@RoutePage()
///Retrieves the user from local storage['user_profile'] created using [User]&&[UserAdapter]
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance History'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
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
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) {
              final data = sessionHistory[index];

              // Format date nicely
              final formattedDate = DateFormat(
                'EEE, MMM d, yyyy • hh:mm:s a',
              ).format(data.dateTime);

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100, // colored tile
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.orange.shade400,
                    child: const Icon(
                      Icons.touch_app,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  title: Text(
                    'Total Taps: ${data.totalTaps}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Time: ${data.totalTime}s • Date: $formattedDate',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade800),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemCount: sessionHistory.length,
          );
        },
      ),
    );
  }
}
