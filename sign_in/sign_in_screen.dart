import 'package:auf/constant.dart';
import 'package:auf/form_bloc/login_form_bloc.dart';
import 'package:auf/helpers/general_method.dart';
import 'package:auf/helpers/http_response.dart';
import 'package:auf/models/user/user_model.dart';
import 'package:auf/models/user/user_response_model.dart';
import 'package:auf/providers/user_data_notifier.dart';
import 'package:auf/public_components/button_primary.dart';
import 'package:auf/public_components/custom_dialog.dart';
import 'package:auf/public_components/input_decoration.dart';
import 'package:auf/public_components/theme_snack_bar.dart';
import 'package:auf/public_components/theme_spinner.dart';
import 'package:auf/screens/forgot_password/forgot_password_screen.dart';
import 'package:auf/screens/navigation_bar/navigation.dart';
import 'package:auf/screens/sign_up/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in-screen';
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kWhite,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Container(
                      width: 250,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Sign in to continue",
                    style: TextStyle(color: kTextGray, fontSize: 14),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: loginForm(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginForm(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFormBloc(),
      child: Builder(builder: (context) {
        final LoginFormBloc formBloc = BlocProvider.of<LoginFormBloc>(context);

        return FormBlocListener<LoginFormBloc, UserModel, UserResponseModel>(
          // On submit
          onSubmitting: (context, state) {
            // Remove focus from input field
            FocusScope.of(context).unfocus();
            // Set loading true
            setState(() {
              _isLoading = true;
            });
          },
          onSuccess: (context, state) {
            // Set loading false
            setState(() {
              _isLoading = false;
            });

            // Declare notifier
            final UserDataNotifier userDataNotifier =
                Provider.of<UserDataNotifier>(context, listen: false);
            // Set to the notifier
            userDataNotifier.setUserData(state.successResponse!);
            // Navigate to home page screen
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => Navigation()),
                (Route<dynamic> route) => false);
          },
          // Validation failed
          onSubmissionFailed: (context, state) {
            // Set loading false
            setState(() {
              _isLoading = false;
            });
          },
          onFailure: (context, state) {
            // Set loading to false
            setState(() {
              _isLoading = false;
            });
            // If failed not null
            if (state.failureResponse != null) {
              if (state.failureResponse!.statusCode !=
                  HttpResponse.HTTP_UNAUTHORIZED) {
                //Set data
                UserModel userModel = new UserModel();
                userModel.email = formBloc.email.value;
                // Hide current snackbar
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                // Email is not verified yet
                if (state.failureResponse!.statusCode ==
                    HttpResponse.HTTP_FORBIDDEN) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          state.failureResponse?.message ?? "Server error"),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: "Verify Now",
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          navigateTo(
                              context,
                              SignUpScreen(
                                activeStepper: 4,
                                userModel: userModel,
                              ));
                        },
                      ),
                    ),
                  );

                  return;
                  // If payment required
                } else if (state.failureResponse!.statusCode ==
                    HttpResponse.HTTP_PAYMENT_REQUIRED) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 5),
                      content: Text(
                          state.failureResponse?.message ?? "Server error"),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: "Pay Now",
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          // Navigate to payment fee confirmation
                          navigateTo(
                              context,
                              SignUpScreen(
                                activeStepper: 5,
                                userModel: userModel,
                              ));
                        },
                      ),
                    ),
                  );

                  return;
                }
              }
            }

            ThemeSnackBar.showSnackBar(
                context, state.failureResponse?.message ?? "Server error");
            return;
          },
          child: Column(
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.email,
                cursorColor: kPrimaryColor,
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  LowerCaseTextFormatter(),
                ],
                decoration: textFieldInputDecoration(
                  "Email",
                  hintText: "ex: example@aufmbz.com",
                  prefixIcon: const Icon(
                    Iconsax.sms,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Password
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.password,
                suffixButton: SuffixButton.obscureText,
                obscureTextTrueIcon: Icon(Iconsax.eye_slash),
                obscureTextFalseIcon: Icon(Iconsax.eye),
                cursorColor: kPrimaryColor,
                decoration: textFieldInputDecoration(
                  "Password",
                  hintText: "Enter your password",
                  prefixIcon: const Icon(
                    Iconsax.unlock,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ScaleTap(
                onPressed: () {
                  navigateTo(context, ForgotPasswordScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Forgot Password?",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              //Button Login
              ButtonPrimary(
                "Login",
                onPressed: formBloc.submit,
                isLoading: _isLoading,
                loadingText: "Signing you in...",
              ),

              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  // Navigator.push(context, route)
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 5),
                    GestureDetector(
                        onTap: () {
                          navigateTo(context, SignUpScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 20, top: 20, bottom: 20),
                          child: RichText(
                            text: const TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
