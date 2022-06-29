import 'package:flutter/material.dart';
import 'package:todo_app/shared/components/component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultTextFormField(
                    label: 'Email Adress',
                    hintText: 'Enter your Email here',
                    border: const OutlineInputBorder(),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Your Email';
                      }
                      return null;
                    },
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    obsecureText: false,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultTextFormField(
                    label: 'Password',
                    hintText: 'Enter your Password here',
                    border: const OutlineInputBorder(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your Password';
                      }
                      return null;
                    },
                    inputType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock_clock_outlined,
                    obsecureText: isPassword,
                    controller: passwordController,
                    sufixIcon: isPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility,
                    suffixPressed: () {
                      setState(() {});

                      isPassword = !isPassword;
                    },
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: defaultMaterialButton(
                          text: const Text('Login'),
                          onPressed: () {
                            setState(() {
                              if (formKey.currentState!.validate()) {
                                print(emailController.text);
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: defaultMaterialButton(
                            text: const Text('Register'), onPressed: () {}),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
