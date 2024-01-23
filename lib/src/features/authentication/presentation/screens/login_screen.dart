import 'package:chatapp/src/features/authentication/auth.dart';
import 'package:chatapp/src/injector_container.dart';
import 'package:chatapp/src/shared/widgets/progress_indicator.dart';
import 'package:chatapp/src/shared/widgets/custom_textform_field_widget.dart';
import 'package:chatapp/src/shared/widgets/default_button_widget.dart';
import 'package:chatapp/src/shared/widgets/snackbar_global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthCubit _authCubit = serviceLocator<AuthCubit>();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: 926.h,
        width: 428.w,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAuthCubitListener(),

                SizedBox(height: 150.h),
                Text('Bienvenido a Chat app',
                    style:
                        TextStyle(fontSize: 27.h, fontWeight: FontWeight.bold)),
                SizedBox(height: 10.h),
                Text('Ingresa tus credenciales para poder continuar.',
                    style: TextStyle(fontSize: 16.h)),
                SizedBox(height: 40.h),
                Text('Correo electrónico',
                    style:
                        TextStyle(fontSize: 17.h, fontWeight: FontWeight.bold)),
                CustomTextFormFieldWidget(
                    inputType: TextInputType.emailAddress,
                    label: 'Tu correo electrónico',
                    controller: _emailController),
                SizedBox(height: 20.h),
                Text('Contraseña',
                    style:
                        TextStyle(fontSize: 17.h, fontWeight: FontWeight.bold)),
                CustomTextFormFieldWidget(
                    label: 'Tu contraseña',
                    inputType: TextInputType.text,
                    controller: _passwordController,
                    suffix: GestureDetector(
                      onTap: () {
                        isShowPassword = !isShowPassword;
                        setState(() {});
                      },
                      child: FaIcon(
                        isShowPassword
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: const Color(0xff1B202D).withOpacity(.5),
                        //  kPrimaryColor.withOpacity(.5),
                        size: 20,
                      ),
                    ),
                    obscureText: isShowPassword),
                SizedBox(height: 30.h),
                Center(
                    child: DefaultButton(
                        label: 'Iniciar sesión',
                        onPressed: () {
                          _authCubit.login(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );
                          // navigateTo(context, page: const DashboardScreen());
                        })),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('¿Olvidaste tu contraseña?',
                      style: TextStyle(
                        fontSize: 15.h,
                      )),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 1.4.h,
                      width: 110.w,
                      color: Colors.black26,
                    ),
                    Text(' o Inicia sesión con ',
                        style: TextStyle(
                          fontSize: 15.h,
                        )),
                    Container(
                      height: 1.4.h,
                      width: 110.w,
                      color: Colors.black26,
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       'assets/icons/googleL.png',
                //       width: 40,
                //     ),
                //     SizedBox(width: 20.w),
                //     Image.asset(
                //       'assets/icons/facebookL.png',
                //       width: 40,
                //     ),
                //   ],
                // ),
                SizedBox(height: 50.h),
                Center(
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 14.h, color: Colors.black),
                          text: '¿No tienes cuenta?  ',
                          children: [
                        TextSpan(
                          text: 'Registrate',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // navigateTo(context, page: const RegisterScreen());
                            },
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14.h,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ])),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAuthCubitListener() {
    return BlocListener<AuthCubit, AuthState>(
      bloc: _authCubit,
      listener: (context, state) async {
        if (state is AuthLoadingState) {
          showProgressDialog(
            context,
          );
        } else if (state is AuthErrorState) {
          Navigator.pop(context);

          showGlobalSnackbar(context,
              message: state.message ?? 'Algo salió mal');
        } else {
          Navigator.pop(context);
        }
      },
      child: const SizedBox(),
    );
  }
}
