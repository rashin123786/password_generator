import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:password_generator/controller/provider/password_db.dart';
import 'package:password_generator/model/password_model.dart';
import 'package:password_generator/view/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(PasswordModelAdapter().typeId)) {
    Hive.registerAdapter(PasswordModelAdapter());
  }
  await Hive.openBox<PasswordModel>('passwordbox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PasswordController(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
