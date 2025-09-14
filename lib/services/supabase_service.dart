import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  RealtimeChannel liveUpdate(List<String> eventNames, Function() updateData) {
    final channel = Supabase.instance.client.channel('public:socket_events');

    for (final eventName in eventNames) {
      channel.onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: 'socket_events',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'event_name',
          value: eventName,
        ),
        callback: (payload, [ref]) {
          updateData();
        },
      );
    }

    channel.subscribe();
    return channel;
  }

  void removeSupabaseChannel(RealtimeChannel channel) {
    Supabase.instance.client.removeChannel(channel);
  }
}
