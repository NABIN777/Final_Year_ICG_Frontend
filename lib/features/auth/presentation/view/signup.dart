import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imagecaptiongenerator/core/common/snackbar/my_snackbar.dart';
import 'package:imagecaptiongenerator/features/auth/domain/entity/user_entity.dart';
import 'package:imagecaptiongenerator/features/auth/presentation/viewmodel/auth_view_model.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  bool isEmailValid(String email) {
    // Regular expression for a simple email validation
    RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

    return emailRegex.hasMatch(email);
  }

  final _key = GlobalKey<FormState>();
  final _fullnameController = TextEditingController(text: 'Nirajan Khanal');
  final _emailController =
      TextEditingController(text: 'nirajan.khanal777gmail.com');
  final _usernameController = TextEditingController(text: 'Nirajan');
  final _passwordController = TextEditingController(text: 'Nirajan123');
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: SizedBox(
                  width: 250,
                  height: 250,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _key, // Assign the GlobalKey<FormState> to the Form widget
                child: Column(
                  children: [
                    TextFormField(
                      key: const ValueKey('First Name'),
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'First Name',
                        hintText: 'Choose your First Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a First Name';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        top: 15,
                        bottom: 0,
                      ),
                      child: TextFormField(
                        controller: _fullnameController,
                        decoration: const InputDecoration(
                          labelText: 'Last Name',
                          hintText: 'Enter your Last Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Last Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        top: 15,
                        bottom: 0,
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email ID',
                          hintText: 'Enter your Email ID',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !isEmailValid(value)) {
                            return 'Please enter valid email ID';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                        right: 15.0,
                        top: 15,
                        bottom: 0,
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      var user = UserEntity(
                        firstname: _usernameController.text,
                        lastname: _fullnameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                      ref
                          .read(authViewModelProvider.notifier)
                          .registerUser(context, user);

                      if (authState.error != null) {
                        showSnackBar(
                          message: authState.error.toString(),
                          context: context,
                          color: Colors.red,
                        );
                      } else {
                        showSnackBar(
                          message: 'Registered successfully',
                          context: context,
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              child: RichText(
                text: const TextSpan(
                  text: 'Already Registered? ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
