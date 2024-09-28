import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medilabs/all_test/ui/all_test.dart';
import 'package:medilabs/book/ui/order_list.dart';
import 'package:medilabs/dashboard/repository/dashboard_controller.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/lab/web_view.dart';
import 'package:medilabs/login/repository/model/login_response.dart';
import 'package:medilabs/login/ui/login_screen.dart';
import 'package:medilabs/profile/ui/profile_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medilabs/dashboard/home_bottom_bar.dart';
import 'package:medilabs/helper/constant.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  DashboardController dashboardController = Get.find();
  late SharedPreferences sharedPreferences;
  String id = "1";
  bool useriD = false;

  @override
  void initState() {
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: Colors.lightBlueAccent.withOpacity(.06)),
            child: useriD
                ? FutureBuilder(
                    future: dashboardController.getProfile(id),
                    builder: (context, AsyncSnapshot<LoginResponse> snapshot) {
                      if (snapshot.hasData) {
                        LoginData loginData = snapshot.data!.data!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 12, top: 24),
                              child: CircleAvatar(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: loginData.image.toString().isEmpty
                                      ? Image.asset(
                                          "images/lab_1.jpg",
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          loginData.image.toString(),
                                          height: 60,
                                          width: 60,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                loginData.name.toString().isEmpty
                                    ? ""
                                    : "" + loginData.name.toString(),
                                style: TextStyle(
                                    color: Constant.hexToColor(
                                        Constant.primaryBlueMin)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                loginData.email.toString().isEmpty
                                    ? ""
                                    : "" + loginData.email.toString(),
                                style: TextStyle(
                                    color: Constant.hexToColor(
                                        Constant.primaryBlue)),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: 24, bottom: 24, top: 24),
                              child: CircleAvatar(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "images/lab_1.jpg",
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                "",
                                style: TextStyle(
                                    color: Constant.hexToColor(
                                        Constant.primaryBlueMin)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4),
                              child: Text(
                                "",
                                style: TextStyle(
                                    color: Constant.hexToColor(
                                        Constant.primaryBlue)),
                              ),
                            )
                          ],
                        );
                      }
                    })
                : Container(
                    margin: EdgeInsets.only(top: 48),
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    )),
          ),
          ListTile(
            leading: Image.asset(
              "images/home.png",
              width: 20,
              height: 20,
              color: Colors.grey,
            ),
            title: const Text('Home',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              // Get.to(DashboardScreenV1());
            },
          ),
          ListTile(
            leading: Image.asset(
              "images/chemistry.png",
              width: 20,
              height: 20,
              color: Colors.grey,
            ),
            title: const Text('Tests',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              Get.to(AllTest(
                cateogoryTest: false,
                title: 'All Test',
              ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.border_all_rounded,
              color: Colors.grey,
            ),
            title: const Text('Booking History',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            onTap: () {
              Navigator.pop(context);

              if (!useriD) {
                Get.to(LoginScreen());
              } else {
                pushNewScreen(
                  context,
                  screen: OrderList(),
                  withNavBar: true,
                );
              }
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: const Text(
          //     'Account',
          //     style: TextStyle(fontSize: 14, color: Colors.black54),
          //   ),
          //   onTap: () {
          //     // Navigator.pop(context);
          //     // pushNewScreen(
          //     //   context,
          //     //   screen: ProductList("Wishlist",1),
          //     //   withNavBar: true, // OPTIONAL VALUE. True by default.
          //     //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
          //     // );
          //   },
          // ),
          Container(
              margin: EdgeInsets.only(left: 8, bottom: 12, top: 12),
              child: Text("Other Infomartion")),
          ListTile(
            leading: Icon(Icons.note_outlined),
            title: const Text('About us',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              Get.to(AppWebView(typewebview: 1));
            },
          ),
          ListTile(
            leading: Icon(Icons.note_outlined),
            title: const Text('Privacy policy',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              Get.to(AppWebView(typewebview: 2));
            },
          ),

          ListTile(
            leading: Icon(Icons.note_outlined),
            title: const Text('Terms and Conditions',
                style: TextStyle(fontSize: 14, color: Colors.black54)),
            onTap: () {
              Navigator.pop(context);
              Get.to(AppWebView(typewebview: 3));
            },
          ),
          // Container(
          //     margin: EdgeInsets.only(left: 8, bottom: 12, top: 12),
          //     child: Text("Other")),
          Constant.USERLOGGEDIN
              ? ListTile(
                  leading: Icon(Icons.logout),
                  title: const Text('Logout',
                      style: TextStyle(fontSize: 14, color: Colors.black54)),
                  onTap: () {
                    GetStorage().write(Constant.USERID, "");
                    GetStorage().write(Constant.USERID, null);
                    GetStorage().remove(Constant.USERID);
                    Constant.USERLOGGEDIN = false;
                    setPrefs();
                    Get.offAll(HomeBottomBar(0));
                  },
                )
              : Container(),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: const Text('Settings',
          //       style: TextStyle(fontSize: 14, color: Colors.black54)),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: const Text('Languages',
          //       style: TextStyle(fontSize: 14, color: Colors.black54)),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  Future<bool> getPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.getString(Constant.USERID) == null) {
      useriD = false;

      return false;
    } else {
      setState(() {
        id = sharedPreferences.getString(Constant.USERID)!;
      });
      useriD = true;
      return true;
    }
  }

  Future<void> setPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setBool(Constant.USERID, false);
    sharedPreferences.setString(Constant.USERID, "");
    sharedPreferences.remove(Constant.USERID);
    Constant.USERLOGGEDIN = false;
    useriD = false;
  }
}
