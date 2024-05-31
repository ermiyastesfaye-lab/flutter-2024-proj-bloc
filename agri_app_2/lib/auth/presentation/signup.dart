import 'package:agri_app_2/auth/bloc/auth_bloc.dart';
import 'package:agri_app_2/auth/bloc/auth_event.dart';
import 'package:agri_app_2/auth/data_provider/signup_data_provider.dart';
import 'package:agri_app_2/auth/repository/signup_repo.dart';
import 'package:agri_app_2/presentation/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _inputField(
    String labelText,
    TextEditingController controller,
    String? Function(String?)? validator,
  ) {
    return SizedBox(
      width: 200,
      height: 50,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: myColor.primary),
            borderRadius: BorderRadius.circular(5),
          ),
          labelText: labelText,
        ),
        validator: validator,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthRegBloc(authRepository: AuthRegRepository(dataProvider: AuthRegDataProvider())),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      "Create Account",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: myColor.secondary),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Create an account to access available agricultural products",
                      style: TextStyle(fontSize: 18, color: myColor.tertiary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 100),
                  _inputField("Email", emailController, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  }),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 50,
                    child: DropdownButtonFormField<String>(
                      items: ["FARMER", "BUYER"].map((role) {
                        return DropdownMenuItem<String>(
                          value: role,
                          child: Text(role),
                        );
                      }).toList(),
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        labelText: "Role",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _inputField("Password", passwordController, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  }),
                  const SizedBox(height: 20),
                  _inputField("Confirm Password", passwordController, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    return null;
                  }),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: 370,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthRegBloc>(context).add(SignupEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ));
                            GoRouter.of(context).go("/dashBoard");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: myColor.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(fontSize: 18, color: myColor.tertiary),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/logIn');
                        },
                        child:
                            const Text("Log in", style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Handle Google login
                        },
                        icon: const Icon(Icons.android),
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle Facebook login
                        },
                        icon: const Icon(Icons.facebook),
                      ),
                      IconButton(
                        onPressed: () {
                          // Handle Apple login
                        },
                        icon: const Icon(Icons.apple),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}