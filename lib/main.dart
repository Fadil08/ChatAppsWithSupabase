import 'package:flutter/material.dart';
import 'package:flutter_api/auth/sigIn_page.dart';
import 'package:flutter_api/pages/homeChat_page.dart';
import 'package:flutter_api/pages/spalsh_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      // postgrestOptions: PostgrestClientOptions(),
      url: "https://uljrdhyzebuenuebcjxd.supabase.co",
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVsanJkaHl6ZWJ1ZW51ZWJjanhkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDczMDI5NjgsImV4cCI6MjAyMjg3ODk2OH0.cvd4o0kp3ZFrqWcXIzFNiElv7HKa2p0t_wxv_A-2d_A");
  runApp(const MyApp());
}

// final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeChatPage(),
    );
  }
}
