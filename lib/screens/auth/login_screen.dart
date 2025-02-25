import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/custom_text_field.dart';
import '../../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          if (auth.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      validator: Validators.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: true,
                      validator: Validators.password,
                    ),
                    SizedBox(height: 30),
                    if (auth.error != null)
                      Text(
                        auth.error!,
                        style: TextStyle(color: Colors.red),
                      ),
                    CustomButton(
                      label: 'Login',
                      onPressed: _handleLogin,
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/register'),
                      child: Text('Don\'t have an account? Sign up'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      await context.read<AuthProvider>().signIn(email, password);

      if (context.read<AuthProvider>().isAuthenticated) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
