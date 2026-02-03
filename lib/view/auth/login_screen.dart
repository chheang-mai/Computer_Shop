import 'package:computer_shop/service/auth_service.dart';
import 'package:computer_shop/view/auth/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final EmailController = TextEditingController();

  final PasswordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Center(
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.network(
                  "https://www.bing.com/th/id/OIG2.UpV8r.otPcYq5_buemMq?w=540&h=540&c=6&r=0&o=5&dpr=1.3&pid=ImgGn",
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back!!",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 1),
                  Text("Login Your Account", style: TextStyle(fontSize: 15)),
                  SizedBox(height: 20),
                  TextField(
                    controller: EmailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: PasswordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        AuthService.signIn(
                          context,
                          EmailController.text,
                          PasswordController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(400, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color.fromARGB(255, 8, 102, 179),
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text("________ or ________"),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            InkWell(
                              onTap: () {},
                              child: Image.network(
                                "https://static.vecteezy.com/system/resources/thumbnails/024/398/614/small/facebook-logo-icon-isolated-on-transparant-background-free-png.png",
                                fit: BoxFit.cover,
                                height: 60,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Image.network(
                                "https://static.vecteezy.com/system/resources/thumbnails/022/613/027/small/google-icon-logo-symbol-free-png.png",
                                fit: BoxFit.cover,
                                height: 60,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Image.network(
                                "https://static.vecteezy.com/system/resources/previews/023/986/926/non_2x/linkedin-logo-linkedin-logo-transparent-linkedin-icon-transparent-free-free-png.png",
                                fit: BoxFit.cover,
                                height: 60,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an Account? "),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
