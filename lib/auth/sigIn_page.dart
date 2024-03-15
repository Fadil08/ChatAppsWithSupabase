// import 'package:flutter/material.dart';
// import 'package:flutter_api/main.dart';
// import 'package:flutter_api/pages/home.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class MyLoginPage extends StatefulWidget {
//   const MyLoginPage({super.key});

//   @override
//   State<MyLoginPage> createState() => _MyLoginPageState();
// }

// class _MyLoginPageState extends State<MyLoginPage> {
//   final emailcontroler = TextEditingController();
//   final passwwordcontroler = TextEditingController();
//   final usernamecontroler = TextEditingController();

//   Future<void> SighIn() async {
//     try {
//       await supabase.auth.signInWithPassword(
//           password: passwwordcontroler.text.trim(),
//           email: emailcontroler.text.trim());

//       if (!mounted) return;
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (context) => const HomeScreen()));
//     } on AuthException catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("SigIn With Supabase"),
//         centerTitle: true,
//         backgroundColor: Colors.brown[600],
//       ),
//       body: Column(
//         children: [
//           // Container()
//           Container(
//             padding: EdgeInsets.all(8.0),
//             child: TextFormField(
//               autocorrect: true,
//               controller: emailcontroler,
//               obscureText: false,
//               cursorColor: Colors.blue,
//               decoration: InputDecoration(labelText: "email"),
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(8.0),
//             child: TextFormField(
//               autocorrect: true,
//               controller: passwwordcontroler,
//               obscureText: false,
//               cursorColor: Colors.blue,
//               decoration: InputDecoration(labelText: "Password"),
//             ),
//           ),

//           TextButton(
//               onPressed: () {
//                 SighIn();
//               },
//               child: Text("Regiser"))
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_api/auth/signUp_page.dart';
import 'package:flutter_api/pages/ChatPage.dart';
import 'package:flutter_api/widget/constans.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const LoginPage());
  }

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await supabase.auth.signInWithPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.of(context)
          .pushAndRemoveUntil(ChatPage.route(), (route) => false);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (_) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: ListView(
        padding: formPadding,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          formSpacer,
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          formSpacer,
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterPage(
                            isRegistering: false,
                          )));
            },
            child: const Text('register'),
          ),
        ],
      ),
    );
  }
}
