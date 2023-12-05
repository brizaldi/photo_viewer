import 'package:flutter/material.dart';
import 'package:photo_viewer/features/photo/details/presentation/photo_details_page.dart';
import 'package:photo_viewer/features/photo/list/presentation/photo_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Viewer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      routes: {
        Routes.list: (context) => const PhotoListPage(),
        Routes.details: (context) => const PhotoDetailsPage(),
      },
    );
  }
}

class Routes {
  static const String list = '/';
  static const String details = '/details';
}
