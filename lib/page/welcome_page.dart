import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vigenesia/page/login_page.dart';
import 'package:vigenesia/page/register_page.dart';

class WelcomePage extends StatelessWidget {
  static const routeName = '/welcome';
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/img/letter-v.png',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'VIGENESIA',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Visi Generasi Indonesia',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xffBC0BE6),
                    Color(0xff3115AE),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    'Welcome to Vigenesia',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Vigenesia adalah aplikasi yang membantu anda untuk mengenal lebih dekat dengan Vigenesia',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xffBC0BE6),
                      backgroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go(LoginPage.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.grey, width: 1),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
