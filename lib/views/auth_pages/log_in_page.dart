import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //! image logo
              Container(
                  height: 100,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.only())),
              const SizedBox(height: 20),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                icon: Iconsax.paperclip,
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
                    onPressed: () {},
                    child: Text(
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                          fontFamily: 'ge_ss',
                          fontWeight: FontWeight.bold),
                      'نسيت كلمة المرور ؟',
                      textAlign: TextAlign.right,
                    )),
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
                  onPressed: () {
                    ///
                    ///temporary
                    Navigator.pushReplacementNamed(context, AppRoutes.home);

                    isLoading = true;

                    ///
                  },
                  child: isLoading
                      ? const SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        )
                      : const Text('تسجيل الدخول',
                          style: TextStyle(
                            fontFamily: 'vip_hala',
                            color: Colors.white,
                          ))),
              const SizedBox(height: 10),
              //! sign up button
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.signUp);
                  },
                  child: Text('أعمل حساب جديد',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color.fromARGB(255, 28, 113, 194)))),
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
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/icons8-google-48.png'),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: MaterialButton(
                      onPressed: () {},
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
                            image: AssetImage(
                                'assets/images/icons8-facebook-96.png'),
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
    ));
  }
}
