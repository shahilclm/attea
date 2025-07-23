import 'package:attea/features/authentication_screen/service/auth_exception.dart';
import 'package:attea/features/authentication_screen/service/auth_service.dart';
import 'package:attea/widgets/common_textfield.dart';
import 'package:attea/widgets/mini_loading_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '/core/logger.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '/constants/constants.dart';
import '/features/navigation_screen/navigation_screen.dart';
import '/gen/assets.gen.dart';
import '/services/size_utils.dart';
import '/widgets/loading_button.dart';

import '../../../services/shared_pref_services.dart';

class AuthPage extends StatefulWidget {
  static const String path = '/authpage';

  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool isOtpStage = false;
  String fullPhoneNumber = '';
  bool isPhoneValid = false;
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // fetchAndSetPhoneNumber();
    // TODO: implement initState
    super.initState();
  }

  // Future<void> fetchAndSetPhoneNumber() async {
  //   final number = await PhoneNumberHint.getPhoneNumber();
  //   if (number != null && mounted) {
  //     setState(() {
  //       phoneController.text = number.replaceAll('+91', '').trim();
  //       fullPhoneNumber = number.trim();
  //       isPhoneValid = true;
  //     });
  //   }
  // }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPassword.text.trim();
    final emailValidator = EmailValidator(
      errorText: 'Enter a valid email address',
    );

    if (email.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Email is required',
        backgroundColor: CustomColors.scaffoldRed,
        gravity: ToastGravity.TOP,
      );
      return;
    }

    final emailError = emailValidator.call(email);

    if (emailError != null) {
      Fluttertoast.showToast(
        msg: emailError,
        backgroundColor: CustomColors.scaffoldRed,
        gravity: ToastGravity.TOP,
      );
      return;
    }

    if (password != confirmPassword) {
      Fluttertoast.showToast(
        msg: 'Passwords do not match',
        backgroundColor: CustomColors.scaffoldRed,
        gravity: ToastGravity.TOP,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signUpWithApprovedEmail(
        email: email,
        password: password,
      );
      Fluttertoast.showToast(
        msg: 'Signup Successfull!',
        backgroundColor: CustomColors.green,
        gravity: ToastGravity.TOP,
      );
    } catch (e) {
      final errorMessage = AuthException.getFriendlyError(e);
      Fluttertoast.showToast(
        msg: errorMessage,
        backgroundColor: CustomColors.scaffoldRed,
        gravity: ToastGravity.TOP,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Gap(CustomPadding.paddingXXL),
              Gap(CustomPadding.paddingXL),
              Text(
                "Let's get started !",
                style: TextStyle(
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
                color: Colors.black,
                size: 20.v,
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: CustomPadding.paddingXL),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: CustomColors.textColor.withAlpha(25),
              blurRadius: 10,
              spreadRadius: 10,
              offset: Offset(0, -3),
            ),
          ],
          color: CustomColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(CustomPadding.paddingXL),
            topRight: Radius.circular(CustomPadding.paddingXL),
          ),
        ),
        height: 352.v,
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
              ? buildOtpInput(key: ValueKey('otp'))
              : buildPhoneNumberInput(key: ValueKey('phone')),
        ),
      ),
    );
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
            controller: _emailController,
            elevation: 21,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
          ),
          Gap(CustomPadding.paddingLarge),
          CommonTextfield(
            controller: _passwordController,
            elevation: 21,

            hintText: 'Password',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.key,

            sufixIcon: _obscurePassword
                ? Icons.visibility_off
                : Icons.visibility,

            onSuffixTap: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
            obscureText: _obscurePassword,
          ),
          Gap(CustomPadding.paddingLarge),
          CommonTextfield(
            controller: _confirmPassword,
            elevation: 21,

            hintText: 'Confirm Password',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.key,
            sufixIcon: _obscureConfirmPassword
                ? Icons.visibility_off
                : Icons.visibility,
            onSuffixTap: () {
              setState(() {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              });
            },
            obscureText: _obscureConfirmPassword,
          ),
          // Container(
          //   height: 50.v,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(CustomPadding.paddingXL),
          //     color: CustomColors.textfieldphoneColors,
          //   ),
          //   child: IntlPhoneField(
          //     controller: phoneController,
          //     onChanged: (phone) {
          //       fullPhoneNumber = phone.completeNumber;

          //       setState(() {
          //         isPhoneValid = phone.number.length == 10;
          //       });
          //     },
          //     textAlignVertical: TextAlignVertical.center,
          //     autovalidateMode: AutovalidateMode.disabled,
          //     inputFormatters: [],
          //     disableAutoFillHints: false,
          //     disableLengthCheck: false,
          //     initialCountryCode: 'IN',
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 14.v,
          //       fontWeight: FontWeight.w500,
          //     ),
          //     decoration: InputDecoration(
          //       hintStyle: TextStyle(color: CustomColors.textColorLightGrey),
          //       counter: SizedBox(),
          //       hintText: 'Enter Phone Number',
          //       border: InputBorder.none,
          //     ),
          //     dropdownIcon: Icon(Icons.arrow_drop_down),
          //   ),
          // ),
          Gap(CustomPadding.paddingXL),
          MiniLoadingButton(
            borderRadius: CustomPadding.paddingXL,
            text: 'Sign Up',
            onPressed: () {
              if (_formKey.currentState!.validate()) _signUp();
            },
            size: ButtonSize.medium,
          ),
          // LoadingButton(
          //   maxWidth: double.maxFinite,
          //   buttonLoading: false,
          //   text: 'Proceed',
          //   onPressed: isPhoneValid
          //       ? () {
          //           setState(() {
          //             isOtpStage = true;
          //           });
          //         }
          //       : () {
          //           Fluttertoast.showToast(
          //             msg: "Please enter a valid phone number.",
          //             toastLength: Toast.LENGTH_SHORT,
          //             gravity: ToastGravity.CENTER,
          //             backgroundColor: CustomColors.scaffoldRed,
          //             textColor: Colors.white,
          //             fontSize: 14.0,
          //           );
          //         },
          // ),
          // Gap(CustomPadding.paddingLarge),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "OR",
          //       style: TextStyle(
          //         fontSize: 16.v,
          //         fontStyle: FontStyle.italic,
          //         fontWeight: FontWeight.w500,
          //         color: CustomColors.textColorLightGrey,
          //       ),
          //     ),
          //   ],
          // ),
          // Divider(),
          // Gap(CustomPadding.padding),
          // Row(
          //   spacing: CustomPadding.paddingLarge,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     SocialMediaAuthButton(assetPath: Assets.svg.google),
          //     SocialMediaAuthButton(assetPath: Assets.svg.facebook),
          //     SocialMediaAuthButton(assetPath: Assets.svg.gmail),
          //   ],
          // ),
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
        // Gap(CustomPadding.paddingXL),
        Text(
          "Enter OTP",
          style: TextStyle(fontSize: 16.v, fontWeight: FontWeight.w500),
        ),
        // Gap(CustomPadding.paddingXL),
        CustomGap.gapXL,
        Pinput(length: 6, closeKeyboardWhenCompleted: true),
        // Gap(CustomPadding.paddingXL),
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
}
