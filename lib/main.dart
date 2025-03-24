import 'package:clickcart/routes/router.dart';
import 'package:clickcart/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
await Hive.openBox('paymentBox');
  await Hive.openBox('deliveryBox');
  await Hive.openBox('cartBox');
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: IKAppTheme.lightTheme,
      darkTheme: IKAppTheme.darkTheme,
      initialRoute: '/splash',
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
