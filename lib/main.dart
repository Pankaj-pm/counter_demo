import 'package:counter_demo/providers/contact_provider.dart';
import 'package:counter_demo/providers/counter_provider.dart';
import 'package:counter_demo/providers/theme_provider.dart';
import 'package:counter_demo/utils/constant.dart';
import 'package:counter_demo/views/add_contact.dart';
import 'package:counter_demo/views/home_page.dart';
import 'package:counter_demo/views/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(prefs.getBool("isIntroOpen"));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        )
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: Provider.of<ThemeProvider>(context).mode,
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          initialRoute: (prefs.getBool("isIntroOpen") ?? false)
              ? homePage
              : Navigator.defaultRouteName,
          routes: {
            Navigator.defaultRouteName: (context) => IntroScreen(),
            homePage: (context) => MyHomePage(),
            addContact: (context) => AddContact(),
          },
        );
      },
    );
    // return ChangeNotifierProvider(
    //   create: (BuildContext context) => CounterProvider(),
    //   builder: (context, child) {
    //     return MaterialApp(
    //       title: 'Flutter Demo',
    //       theme: ThemeData.light(useMaterial3:  true),
    //       darkTheme: ThemeData.dark(useMaterial3: true),
    //       themeMode: ,
    //       home: const MyHomePage(title: 'Flutter Demo Home Page'),
    //     );
    //   },
    // );
  }
}
