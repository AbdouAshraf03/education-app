import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/data/firebase_auth_service.dart';
import 'package:mr_samy_elmalah/data/firebase_import.dart';
import 'package:mr_samy_elmalah/models/user.dart' as u;
import 'package:mr_samy_elmalah/widgets/custom_text_field.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  static const List<DropdownMenuEntry<int>> _grades = [
    DropdownMenuEntry(
      value: 1,
      label: 'الصف الاول الثانوي',
      labelWidget: Text(
        'الصف الاول الثانوي',
        style: TextStyle(fontFamily: 'ge_ss', fontWeight: FontWeight.bold),
      ),
    ),
    DropdownMenuEntry(
      value: 2,
      label: 'الصف الثاني الثانوي',
      labelWidget: Text(
        'الصف الثاني الثانوي',
        style: TextStyle(fontFamily: 'ge_ss', fontWeight: FontWeight.bold),
      ),
    ),
    DropdownMenuEntry(
      value: 3,
      label: 'الصف الثالث الثانوي',
      labelWidget: Text(
        'الصف الثالث الثانوي',
        style: TextStyle(fontFamily: 'ge_ss', fontWeight: FontWeight.bold),
      ),
    ),
  ];

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passController = TextEditingController();

  final TextEditingController _fnameController = TextEditingController();

  final TextEditingController _lnameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _cpassController = TextEditingController();

  bool isLoading = false;

  dynamic _selectedGrade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Theme.of(context).primaryIconTheme.color,
          ),
          shadowColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Center(
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
                            color: Colors.blue,
                            borderRadius: BorderRadius.only())),
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
                        Text('أنشاء حساب',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
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
                    //! first name
                    CustomTextField(
                      keyboardType: TextInputType.name,
                      labelText: 'الاسم الاول',
                      controller: _fnameController,
                      icon: Iconsax.user,
                    ),
                    const SizedBox(height: 20),
                    //! last name
                    CustomTextField(
                      keyboardType: TextInputType.name,
                      labelText: 'اسم العائلة',
                      controller: _lnameController,
                      icon: Iconsax.people,
                    ),
                    const SizedBox(height: 20),
                    //! grade
                    // DropdownButton<int>(
                    //   items: grades,
                    //   value: _selectedGrade,
                    //   itemHeight: 55,
                    //   isExpanded: true,
                    //   menuWidth: MediaQuery.of(context).size.width - 20,
                    //   borderRadius: BorderRadius.circular(10),
                    //   onChanged: (value) {
                    //     value = _selectedGrade;
                    //     print(_selectedGrade);
                    //   },
                    // ),
                    DropdownMenu(
                        dropdownMenuEntries: SignUpPage._grades,
                        initialSelection: _selectedGrade,
                        width: MediaQuery.of(context).size.width - 20,
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: const TextStyle(fontFamily: 'ge_ss'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        menuStyle: MenuStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        )),
                        label: Text('الصف الدراسي',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                        leadingIcon: Icon(Iconsax.book_1, color: Colors.grey),
                        onSelected: (value) => _selectedGrade = value),
                    const SizedBox(height: 20),
                    //! phone
                    CustomTextField(
                      keyboardType: TextInputType.phone,
                      labelText: 'رقم الهاتف',
                      controller: _phoneController,
                      icon: Iconsax.call_add,
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 20),
                    //! password confirm
                    CustomTextField(
                        keyboardType: TextInputType.visiblePassword,
                        labelText: 'تاكيد كلمه المرور',
                        controller: _cpassController,
                        icon: Iconsax.lock,
                        isPassword: true),
                    const SizedBox(height: 20),
                    //! sgin up button
                    MaterialButton(
                      height: 55,
                      minWidth: MediaQuery.of(context).size.width - 20,
                      color: Color.fromARGB(255, 28, 113, 194),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        if (_passController.text != _cpassController.text) {
                          CustomDialog(
                            dialogType: DialogType.error,
                            title: 'خطأ',
                            desc: 'كلمة المرور غير متطابقة',
                          ).showdialog(context);
                          return;
                        }
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          u.User user = u.User(
                            fname: _fnameController.text,
                            lname: _lnameController.text,
                            graduate: _selectedGrade.toString(),
                            phoneNumber: _phoneController.text,
                            email: _emailController.text,
                          );
                          Map<String, String> mainUserData = user.mapOfUser;
                          UserCredential? credential =
                              await FirebaseAuthService().normalSignUp(
                            _emailController.text,
                            _passController.text,
                            context,
                          );

                          if (credential?.user != null) {
                            await FirebaseAuth.instance.currentUser!
                                .sendEmailVerification();
                            await FirebaseImport().importUserData(mainUserData);
                            setState(() {
                              isLoading = false;
                            });
                            if (context.mounted) {
                              const snackBar = SnackBar(
                                content: Text(
                                    'Sign up Successful check your email to verify your account'),
                                duration: Duration(seconds: 5),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.logIn);
                            }
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        } catch (e) {
                          // print(e);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                      child: isLoading
                          ? SizedBox(
                              height: 50, width: 50, child: LottieLoader())
                          : const Text('تسجيل ',
                              style: TextStyle(
                                fontFamily: 'vip_hala',
                                color: Colors.white,
                              )),
                    ),
                    const SizedBox(height: 40),
                  ]),
            ),
          ),
        ));
  }
}
