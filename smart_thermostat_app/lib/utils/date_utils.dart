import 'package:intl/intl.dart';
 
String formatDateTime(DateTime dt) => DateFormat.yMd().add_jm().format(dt);
String formatDuration(Duration d) => d.inMinutes > 60
    ? '${d.inHours}h ${d.inMinutes % 60}m'
    : '${d.inMinutes} min'; 