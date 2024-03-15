import 'package:flutter/material.dart';
import 'package:flutter_api/auth/signUp_page.dart';
import 'package:flutter_api/pages/ChatPage.dart';
import 'package:flutter_api/widget/constans.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Page to redirect users to the appropriate page depending on the initial auth state
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  final session = Supabase.instance.client.auth.currentSession;
  Future<void> _redirect() async {
    // await for for the widget to mount
    await Future.delayed(Duration.zero);

    // if (session == null) {
    //   Navigator.of(context)
    //       .pushAndRemoveUntil(RegisterPage.route(), (route) => false);
    // } else {
    //   Navigator.of(context)
    //       .pushAndRemoveUntil(ChatPage.route(), (route) => false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: preloader);
  }
}
