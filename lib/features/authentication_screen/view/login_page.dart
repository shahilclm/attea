import 'package:attea/features/authentication_screen/service/auth_exception.dart';
import 'package:attea/features/authentication_screen/service/auth_service.dart';
import 'package:attea/widgets/common_textfield.dart';
import 'package:attea/widgets/mini_loading_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gaimon/gaimon.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../../extensions/app_theme_extensions.dart';
import '../../../services/shared_pref_services.dart';
import '../controllers/login_controllers.dart';
import '/constants/constants.dart';
import '/core/logger.dart';
import '/features/navigation_screen/navigation_screen.dart';
import '/gen/assets.gen.dart';
import '/services/size_utils.dart';
import '/widgets/loading_button.dart';

class LoginPage extends StatefulWidget {
  static const String path = '/loginpage';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginFormController formController = LoginFormController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _obscurePassword = true;

  final AuthService _authService = AuthService();

  bool isOtpStage = false;
  String fullPhoneNumber = '';
  bool isPhoneValid = false;

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final email = formController.emailController.text.trim();
    final password = formController.passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Gaimon.error();
      setState(() => _isLoading = false);

      Fluttertoast.showToast(
        msg: 'Email and password are required',
        backgroundColor: CustomColors.scaffoldRed,
        gravity: ToastGravity.TOP,
      );
      return;
    }

    try {
      await _authService.loginWithEmail(email: email, password: password);

      Fluttertoast.showToast(
        msg: 'Login successful!',
        backgroundColor: CustomColors.green,
        gravity: ToastGravity.TOP,
      );

      if (!mounted) return;
      Navigator.pushNamed(context, NavigationScreen.path);
    } on FirebaseAuthException catch (e) {
      final message = AuthException.getFriendlyError(e);
      Fluttertoast.showToast(
        msg: message,
        backgroundColor: CustomColors.scaffoldRed,
        gravity: ToastGravity.TOP,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong. Please try again.',
        backgroundColor: CustomColors.scaffoldRed,
        gravity: ToastGravity.TOP,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> saveToken() async {
    await SharedPreferencesService.i.setValue(
      key: 'token',
      value: 'sampleValue',
    );

    final token = SharedPreferencesService.i.getValue(key: 'token');
    logWarning('Token saved successfully $token');
  }

  Widget buildPhoneNumberInput({Key? key}) {
    return Form(
      key: _formKey,
      child: Column(
        key: key,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(CustomPadding.paddingLarge),
          Gap(CustomPadding.paddingLarge),

          CommonTextfield(
            controller: formController.emailController,
            elevation: 1,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
          ),

          Gap(CustomPadding.paddingLarge),

          CommonTextfield(
            controller: formController.passwordController,
            elevation: 1,
            hintText: 'Password',
            keyboardType: TextInputType.visiblePassword,
            prefixIcon: Icons.key,
            obscureText: _obscurePassword,
            sufixIcon: _obscurePassword
                ? Icons.visibility_off
                : Icons.visibility,
            onSuffixTap: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),

          Gap(CustomPadding.paddingLarge),
          Gap(CustomPadding.paddingXL),

          MiniLoadingButton(
            isLoading: _isLoading,
            borderRadius: CustomPadding.paddingXL,
            text: 'Login',
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _login();
              }
            },
            size: ButtonSize.medium,
          ),
        ],
      ),
    );
  }

  Widget buildOtpInput({Key? key}) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomGap.gapXL,
        Text(
          "Enter OTP",
          style: TextStyle(fontSize: 16.v, fontWeight: FontWeight.w500),
        ),
        CustomGap.gapXL,
        Pinput(length: 6, closeKeyboardWhenCompleted: true),
        CustomGap.gapXL,
        LoadingButton(
          maxWidth: double.maxFinite,
          buttonLoading: false,
          text: 'Verify OTP',
          onPressed: () {
            saveToken();
            Navigator.pushNamed(context, NavigationScreen.path);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppThemeColors>()!;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Gap(CustomPadding.paddingXXL),
              Gap(CustomPadding.paddingXL),
              Text(
                "Welcome back!",
                style: TextStyle(
                  color: appColors.textContrastColor,
                  fontSize: 24.fSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(CustomPadding.paddingLarge),
                child: Lottie.asset(
                  Assets.lotties.authLottie2,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Positioned(
            top: kTextTabBarHeight / 2.v,
            left: CustomPadding.padding,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: appColors.dynamicIconColor,
                size: 20.v,
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: CustomPadding.paddingXL),
        decoration: BoxDecoration(
          color: appColors.background.withValues(alpha: 225),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(CustomPadding.paddingXL),
            topRight: Radius.circular(CustomPadding.paddingXL),
          ),
        ),
        height: 300.v,
        width: double.infinity,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.2),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: isOtpStage
              ? buildOtpInput(key: const ValueKey('otp'))
              : buildPhoneNumberInput(key: const ValueKey('phone')),
        ),
      ),
    );
  }
}
