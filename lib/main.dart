import 'package:blog/utils/route_generator.dart';
import 'package:blog/utils/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme().appTheme,
      initialRoute: '/my-ads',
      onGenerateRoute: RouteGenerator().generateRoute,
    );
  }
}
