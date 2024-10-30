import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stat_table/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.routes,
      theme: ThemeData(
        primaryColor: Colors.blue,
        colorScheme: const ColorScheme.light(primary: Colors.blue),
        textTheme: Theme.of(context).textTheme.apply(
            decorationColor: Colors.blue),
        inputDecorationTheme: const InputDecorationTheme(
          prefixIconColor: Colors.black54,
          suffixIconColor: Colors.black54,
          iconColor: Colors.black54,
          labelStyle: TextStyle(color: Colors.black54),
          hintStyle: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}