// import 'package:flutter/material.dart';
// import 'package:flutter_api/main.dart';
// import 'package:flutter_api/pages/home.dart';
// import 'package:flutter_api/widget/constans.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class MySignUp extends StatefulWidget {
//   const MySignUp({super.key});

//   @override
//   State<MySignUp> createState() => _MySignUpState();
// }

// class _MySignUpState extends State<MySignUp> {
//   final emailcontroler = TextEditingController();
//   final passwwordcontroler = TextEditingController();
//   final usernamecontroler = TextEditingController();
//   Future<void> SignUp() async {
//     try {
//       await supabase.auth.signUp(
//           password: passwwordcontroler.text.trim(),
//           email: emailcontroler.text.trim(),
//           data: {'username': usernamecontroler.text.trim()});
//       await supabase
//           .from('profiles')
//           .insert({'username': usernamecontroler.text.trim()});
//       if (!mounted) {
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (context) => const HomeScreen()));
//       }
//     } on AuthException catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("SIgnUp With Supabase"),
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
//               controller: usernamecontroler,
//               obscureText: false,
//               cursorColor: Colors.blue,
//               decoration: InputDecoration(labelText: "username"),
//             ),
//           ),
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
//                 SignUp();
//               },
//               child: Text("Sig In"))
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_api/auth/sigIn_page.dart';
import 'package:flutter_api/widget/constans.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.isRegistering}) : super(key: key);

  static Route<void> route({bool isRegistering = false}) {
    return MaterialPageRoute(
      builder: (context) => RegisterPage(isRegistering: isRegistering),
    );
  }

  final bool isRegistering;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  Future<void> _signUp() async {
    // final isValid = _formKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    final email = _emailController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;
    try {
      await supabase.auth.signUp(
          email: email.trim(),
          password: password.trim(),
          data: {'username': username.trim()});
      // supabase.from('profiles').insert({"profile_id": username.trim()});
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => LoginPage()));
      // Navigator.of(context)
      //     .pushAndRemoveUntil(ChatPage.route(), (route) => false);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: formPadding,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            formSpacer,
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('Password'),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Required';
                }
                if (val.length < 6) {
                  return '6 characters minimum';
                }
                return null;
              },
            ),
            formSpacer,
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                label: Text('Username'),
              ),
              // validator: (val) {
              //   if (val == null || val.isEmpty) {
              //     return 'Required';
              //   }
              //   // final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
              //   if (!isValid) {
              //     return '3-24 long with alphanumeric or underscore';
              //   }
              //   return null;
              // },
            ),
            formSpacer,
            ElevatedButton(
              onPressed: _isLoading ? null : _signUp,
              child: const Text('Register'),
            ),
            formSpacer,
            TextButton(
              onPressed: () {
                Navigator.of(context).push(LoginPage.route());
              },
              child: const Text('I already have an account'),
            )
          ],
        ),
      ),
    );
  }
}