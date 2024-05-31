import 'package:agri_app_2/auth/bloc/login_bloc.dart';
import 'package:agri_app_2/auth/bloc/login_event.dart';
import 'package:agri_app_2/auth/bloc/login_state.dart';
import 'package:agri_app_2/auth/data_provider/signin_data_provider.dart';
import 'package:agri_app_2/auth/model/signin_model.dart';
import 'package:agri_app_2/auth/repository/signin_repo.dart';
import 'package:agri_app_2/presentation/data/dummy_data.dart';
import 'package:agri_app_2/presentation/screens/dash_board.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final sharedPreferences = snapshot.data!;
          return BlocProvider(
            create: (context) => LoginBloc(
              AuthRepository(
                AuthDataProvider(Dio()), // Initialize with Dio instance
                sharedPreferences, // Use SharedPreferences instance from FutureBuilder
              ),
            ),
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  GoRouter.of(context).go("/dashBoard");
                } else if (state is LoginError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: LoginForm(
                emailController: _emailController,
                passwordController: _passwordController,
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Role? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 100, right: 16, left: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: myColor.secondary,
                  ),
                ),
              ),
              Text(
                "Welcome back you've been missed!",
                style: TextStyle(fontSize: 18, color: myColor.tertiary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
              _inputField("Email", widget.emailController, (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              }),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: DropdownButtonFormField<Role>(
                  items: Role.values.map((Role role) {
                    return DropdownMenuItem<Role>(
                      value: role,
                      child: Text(role.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (Role? newRole) {
                    setState(() {
                      _selectedRole = newRole;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: "Role",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _inputField("Password", widget.passwordController, (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              }, isPassword: true),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 370,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_selectedRole != null) {
                        BlocProvider.of<LoginBloc>(context).add(
                          LoginRequested(
                            email: widget.emailController.text,
                            password: widget.passwordController.text,
                            role: _selectedRole!,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a role'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: myColor.secondary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {
                     GoRouter.of(context).go("/signUp");
                  },
                  child: Text("Don't have an account? Sign up",
                      style: TextStyle(fontSize: 18, color: myColor.tertiary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
    String label,
    TextEditingController controller,
    String? Function(String?) validator, {
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      validator: validator,
    );
  }
}

// enum Role { FARMER, BUYER } // Assuming these are the roles available in your app