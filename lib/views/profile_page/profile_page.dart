import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';
import 'package:mr_samy_elmalah/widgets/custom_text_field.dart';
import 'package:mr_samy_elmalah/widgets/small_widgets.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passController = TextEditingController();
  final TextEditingController _codeController =
      TextEditingController(text: 'DS33D');
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _cpassController = TextEditingController();
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
  bool isLoading = false;
  dynamic _selectedGrade;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: false,
        actions: [
          Center(
            child: Text(
              "الاقسام",
              // textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 20),
          Icon(Iconsax.book_copy, color: Theme.of(context).primaryColor),
          SizedBox(width: 20),
          AnimatedMenuButton()
        ],
        leading: IconButton(
          onPressed: () => Navigator.pushReplacementNamed(
              context, AppRoutes.mainPage,
              arguments: 0),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).primaryIconTheme.color,
          ),
        ),
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
                  // Container(
                  //     height: 100,
                  //     width: 100,
                  //     decoration: const BoxDecoration(
                  //         color: Colors.blue,
                  //         borderRadius: BorderRadius.only())),
                  // const SizedBox(height: 20),
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
                      Text('الملف الشخصي',
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
                      dropdownMenuEntries: _grades,
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
                  //! code
                  _buildCustomtextfield(context),
                  const SizedBox(height: 20),
                  //! sgin up button
                  MaterialButton(
                      height: 55,
                      minWidth: MediaQuery.of(context).size.width - 20,
                      color: Color.fromARGB(255, 28, 113, 194),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        ///
                        isLoading = true;

                        ///
                      },
                      child: isLoading
                          ? SizedBox(
                              height: 40,
                              width: 40,
                              child: LottieLoader(),
                            )
                          : const Text('تعديل',
                              style: TextStyle(
                                fontFamily: 'vip_hala',
                                color: Colors.white,
                              ))),
                  const SizedBox(height: 40),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomtextfield(BuildContext context) {
    return TextField(
      enabled: false,
      controller: _codeController,
      keyboardType: TextInputType.emailAddress,
      //obscureText: passwordVisible,
      enableSuggestions: false,
      // textDirection: TextDirection.rtl,
      cursorColor: const Color.fromARGB(255, 28, 113, 194),
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontFamily: 'roboto'),

      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 28, 113, 194),
            )),
        prefixIcon: Icon(Icons.abc, color: Colors.grey),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        labelText: 'كود الطالب',
        labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey,
              textBaseline: TextBaseline.alphabetic,
            ),
      ),
    );
  }
}
