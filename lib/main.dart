import 'package:flutter/material.dart';


import 'package:dynamic_color/dynamic_color.dart';
import 'package:todoist_bullatize/sharedPrefHelper.dart';
import 'package:todoist_bullatize/theme.dart';
import 'package:todoist_bullatize/ui/ProjectsListScreen.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp(
          title : "Todoist Bullatize",
          theme: ThemeData(
            colorScheme: lightColorScheme ?? MaterialTheme.lightScheme(),
            useMaterial3: true
          ),
          darkTheme: ThemeData(
            colorScheme: darkColorScheme?? MaterialTheme.darkScheme(),
            useMaterial3: true
          ),
          home: const ProjectsListScreen(),
        );
      }
    );
  }
}
