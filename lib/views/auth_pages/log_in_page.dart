import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/data/firebase_auth_service.dart';
import 'package:mr_samy_elmalah/widgets/custom_text_field.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';

import '../../core/app_assets.dart';

// ignore: must_be_immutable
class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //! image logo
                  Container(
                    height: 180,
                    width: 180,
                    decoration: const BoxDecoration(
                      //color: Colors.blue,
                      image: DecorationImage(
                          image: AssetImage(LogoAppAssets.logoNoPg)),
                      //borderRadius: BorderRadius.only(),
                    ),
                  ),
                  //! title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   '∫',
                      //   style: TextStyle(
                      //       fontSize: 40,
                      //       fontFamily: 'vip_hala',
                      //       color: Color.fromARGB(255, 28, 113, 194)),
                      // ),
                      Text(' تسجيل الدخول ',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontFamily: 'vip_hala',
                                    fontSize: 24,
                                  )),
                      // Text(
                      //   'dx',
                      //   style: TextStyle(
                      //       fontSize: 22,
                      //       fontFamily: 'vip_hala',
                      //       color: Color.fromARGB(255, 28, 113, 194)),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  //! email
                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'الأيميل',
                    controller: _emailController,
                    icon: Iconsax.paperclip_copy,
                  ),
                  const SizedBox(height: 20),
                  //! password
                  CustomTextField(
                      keyboardType: TextInputType.visiblePassword,
                      labelText: 'كلمه المرور',
                      controller: _passController,
                      icon: Iconsax.lock,
                      isPassword: true),
                  //const SizedBox(height: 3),
                  //! forgot password
                  Container(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _emailController.text);
                          if (context.mounted) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.topSlide,
                              title: 'Successful reset password',
                              desc: 'Please check your email to reset password',
                            ).show();
                          }
                        } on FirebaseAuthException catch (e) {
                          if (context.mounted) {
                            CustomDialog(
                              title: 'error',
                              desc: e.code,
                              dialogType: DialogType.error,
                            ).showdialog(context);
                          }
                        }
                      },
                      child: Text(
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            fontFamily: 'ge_ss',
                            fontWeight: FontWeight.bold),
                        'نسيت كلمة المرور ؟',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //! login button
                  MaterialButton(
                      height: 55,
                      minWidth: MediaQuery.of(context).size.width - 20,
                      color: Color.fromARGB(255, 28, 113, 194),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await FirebaseAuthService().normalSignIn(
                            _emailController.text,
                            _passController.text,
                            context,
                          );

                          User? user = FirebaseAuth.instance.currentUser;
                          if (!(user!.emailVerified)) {
                            if (context.mounted) {
                              await AwesomeDialog(
                                context: context,
                                dialogType: DialogType.info,
                                animType: AnimType.rightSlide,
                                title: 'Notice',
                                desc: 'Please verify your email first',
                              ).show();
                            }
                            await FirebaseAuth.instance.signOut();
                          } else {
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(
                                context,
                                AppRoutes.mainPage,
                                arguments: 0,
                              );
                            }
                          }
                        } catch (e) {
                          print(e);
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading
                          ? const SizedBox(
                              height: 40,
                              width: 40,
                              child: LottieLoader(),
                            )
                          : const Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontFamily: 'vip_hala',
                                color: Colors.white,
                              ),
                            )),
                  const SizedBox(height: 10),
                  //! sign up button
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signUp);
                    },
                    child: Text(
                      'أعمل حساب جديد',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color.fromARGB(255, 28, 113, 194),
                          ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //! or
                  Text('━━━━━━━ أو ━━━━━━━'),
                  const SizedBox(height: 20),
                  //! google and facebook button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //? google button
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            color: const Color.fromARGB(255, 233, 235, 255),
                            image: isLoading
                                ? null
                                : DecorationImage(
                                    image: AssetImage(
                                      ImageAppAssets.google48,
                                    ),
                                  ),
                            borderRadius: BorderRadius.circular(10)),
                        child: isLoading
                            ? LottieLoader()
                            : MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  FirebaseAuthService()
                                      .signInWithGoogle(context)
                                      .then((_) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });
                                },
                              ),
                      ),
                      const SizedBox(width: 10),
                      //? facebook button
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                            image: DecorationImage(
                                image: AssetImage(ImageAppAssets.facebook96),
                                scale: 1.9),
                            color: Color(0xff039BE5),
                            borderRadius: BorderRadius.circular(10)),
                        child: MaterialButton(
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ),
      ),
    ));
  }
}
