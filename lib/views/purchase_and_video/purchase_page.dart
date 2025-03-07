import 'package:flutter/material.dart';

import 'package:mr_samy_elmalah/core/app_routes.dart';
import 'package:mr_samy_elmalah/widgets/custom_drawer.dart';
import 'package:mr_samy_elmalah/widgets/custom_menu_animation.dart';

class PurchasePage extends StatelessWidget {
  const PurchasePage({super.key, required this.routeArg});
  final Map<String, dynamic> routeArg;
  static final TextEditingController _textFieldController =
      TextEditingController();
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'ادخل كود المحاضرة',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'roboto',
                ),
          ),
          content: TextField(
            controller: _textFieldController,
            keyboardType: TextInputType.multiline,
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
              // prefixIcon: Icon(, color: Colors.grey),
              floatingLabelAlignment: FloatingLabelAlignment.start,

              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              labelText: 'الكود',
              labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey,
                    textBaseline: TextBaseline.alphabetic,
                  ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                print(_textFieldController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        shadowColor: Colors.transparent,
        centerTitle: false,

        // title: Text(
        //   "شراء المحاضرة",
        //   //textAlign: TextAlign.right,
        //   style: Theme.of(context)
        //       .textTheme
        //       .bodyMedium!
        //       .copyWith(fontWeight: FontWeight.bold),
        // ),
        actions: [
          Center(
            child: Text(
              "شراء المحاضرة",
              // textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: 20),
          Icon(Icons.play_lesson_rounded,
              color: Theme.of(context).primaryColor),
          SizedBox(width: 20),
          AnimatedMenuButton()
        ],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).primaryIconTheme.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //! image
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      routeArg['image_url'],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              //! title
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  routeArg['title'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              SizedBox(height: 20),
              //! mony
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      routeArg['price'].toString(),
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(width: 5),
                    Text(
                      ': سعر المحاضرة ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              //! purchase bottom
              MaterialButton(
                onPressed: () {
                  _displayTextInputDialog(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 45,
                minWidth: MediaQuery.of(context).size.width - 40,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'شراء المحاضره',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 45),
              //! video section name
              SizedBox(
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  'المحاضرات',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 127, 127, 127)),
                ),
              ),
              SizedBox(height: 20),
              //! videos
              SizedBox(
                height: 250,
                child: ListView.builder(
                    itemCount: routeArg['video_url']!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.videoPlayerPage,
                                  arguments: routeArg['video_url']![index]);
                            },
                            title: Text(
                              'part ${index + 1}',
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            trailing: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Icon(
                                  Icons.video_collection_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 5,
                            color: Colors.black,
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
