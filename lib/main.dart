import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:nepeve/support/noti.dart';
import 'package:nepeve/support/pastevents.dart';
import 'package:nepeve/util/favorite.dart';
import 'package:nepeve/widgets/theme.dart';
import 'package:nepeve/screens/checkin.dart';
import 'package:nepeve/support/notification.dart';
import 'package:provider/provider.dart';
import 'auth.dart';
import 'root_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            theme: notifier.darkTheme ? dark : light,
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (context) => new RootPage(auth: new Auth()),
              '/checkin': (context) => CheckinPage(),
              '/favorite': (context) => Favorites(),
              '/pastevents': (context) => PastEventsView(),
              '/notification': (context) => NotificationsPage(),
              // '/noti': (context) => PushMessagingExample(),
            },
          );
        },
      ),
    );
  }
}
