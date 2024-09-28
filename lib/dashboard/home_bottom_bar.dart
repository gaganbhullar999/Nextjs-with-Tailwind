import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medilabs/book/ui/order_list.dart';
import 'package:medilabs/cart/ui/cart_list.dart';
import 'package:medilabs/lab/model/lab_model.dart';
import 'package:medilabs/login/ui/login_screen.dart';
import 'package:medilabs/profile/ui/profile_screen.dart';
import 'package:medilabs/reports/ui/reports.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dashboard_screen.dart';
import 'package:permission_handler/permission_handler.dart' as permissionHandler;

class HomeBottomBar extends StatefulWidget {
  final int index;


  HomeBottomBar(this.index);

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();


}

class _HomeBottomBarState extends State<HomeBottomBar> {
  bool _permissionCheck = false;
  late PersistentTabController _controller;

  final iconList = const [
    "images/home.png",
    "images/chemistry.png",
    "images/sanitizer.png",
    "images/notification.png",
    "images/user.png"
  ];

  bool useriD = false;

int tabcount=0;
   @override
  void initState() {
     _controller= PersistentTabController(initialIndex:widget.index);
     // checkpermittion();
     // _checkLocationPermission3();
     getPrefs();
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog( //show confirm dialogue
        //the return value will be from "Yes" or "No" options
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit an App?'),
          actions:[
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              //return false when click on "NO"
              child:Text('No'),
            ),

            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              //return true when click on "Yes"
              child:Text('Yes'),
            ),

          ],
        ),
      )??false; //if showDialouge had returned null, then return false
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: tabcount==0 ? showExitPopup: null,
        // onWillPop: showExitPopup,() async {
        //   SystemNavigator.pop();
        //
        //   return true;
        // },

      child: PersistentTabView(

      context,

//export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
      //export /Applications/Android Studio.app/Contents/jbr/Contents/Home
        // export /Applications/Android Studio.app/Contents/jbr/Contents/Home
        // export JAVA_HOME=/Applications/Android Studio.app/Contents/jbr/Contents/Home
        // export JAVA_HOME=/Applications/Android Studio.app/Contents/jbr/Contents/Home

      //<key>NSLocationAlwaysUsageDescription</key>
        //     <string>Needed to access location</string>
        //     <key>NSLocationWhenInUseUsageDescription</key>
        //     <string>Needed to access location</string>


      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: false,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, //
      onItemSelected: (int) {
        print("backkkkkkkkkkkk00 ${int}");
        tabcount=int;
        setState(() {

        }); // This is required to update the nav bar if Android back button is pressed
      },

      // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
    ),
    ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      DashboardScreen(),
      // OrderList(),
       !useriD?LoginScreen(): OrderList(),
      // ReportScreen(),
      // ProfileScreen(),
      !useriD? LoginScreen() : ProfileScreen(),

    ];


  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [

      PersistentBottomNavBarItem(
        icon: Image.asset(iconList[0],color:Constant.hexToColor(Constant.primaryBlue) ,height: 20,width: 20,),
        title: ("Home"),
        activeColorPrimary: Constant.hexToColor(Constant.primaryBlue),
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(iconList[1],color:Constant.hexToColor(Constant.primaryBlue),height: 20,width: 20,),
        title: ("History"),
        activeColorPrimary: Constant.hexToColor(Constant.primaryBlue),
        inactiveColorPrimary: Colors.grey,
      ),
      // PersistentBottomNavBarItem(
      //   icon: Image.asset(iconList[2],color:Constant.hexToColor(Constant.primaryBlue),height: 20,width: 20,),
      //   title: ("Reports"),
      //   activeColorPrimary: Constant.hexToColor(Constant.primaryBlue),
      //   inactiveColorPrimary: Colors.grey,
      // ),

      // PersistentBottomNavBarItem(
      //   icon:Icon(Icons.shopping_cart_outlined,color:Constant.hexToColor(Constant.primaryBlue),),
      //   title: ("Cart"),
      //   activeColorPrimary: Constant.hexToColor(Constant.primaryBlue),
      //   inactiveColorPrimary: Colors.grey,
      // ),

      PersistentBottomNavBarItem(
        icon: Icon(Icons.person_outline,color: Constant.hexToColor(Constant.primaryBlue),),
        title: ("Profile"),
        activeColorPrimary: Constant.hexToColor(Constant.primaryBlue),
        inactiveColorPrimary: Colors.grey,
      ),
    ];


  }


  Future<void> checkpermittion() async {

    final serviceStatusLocation = await Permission.locationWhenInUse.isGranted ;

    bool isLocation = serviceStatusLocation == ServiceStatus.enabled;

    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      print('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }
  }


  _checkLocationPermission3() async {
    _permissionCheck = false;
    permissionHandler.PermissionStatus? status;
    if(Platform.isAndroid){
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus> result = await [permissionHandler.Permission.location].request();
      status = result[permissionHandler.Permission.location];
    }else{
      Map<permissionHandler.Permission, permissionHandler.PermissionStatus> result = await [permissionHandler.Permission.locationWhenInUse].request();
      status = result[permissionHandler.Permission.locationWhenInUse];
    }
    // printMsg('status $status');
    print('status $status');
    if (status == permissionHandler.PermissionStatus.granted) {
      // _proceedToNextScreen();
      print('permi yes');
      _permissionCheck = true;
    } else {
      print('permi Nooooo');
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Location Permission'),
          content: const Text('Please allow location permission from settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
            if (Platform.isAndroid &&
            status == permissionHandler.PermissionStatus.denied) {
            _checkLocationPermission3();
            } else {
            print('permi Nooooo Setting');
            // AppSettings.openAppSettings();
            }
            },
              child: const Text('Ok'),
            ),
            // TextButton(
            //   onPressed: () => Navigator.pop(context, 'OK'),
            //   child: const Text('OK'),
            // ),
          ],
        ),
      );



      // showDialog2("Please allow location permission from settings.",
      //     okBtnClick: () async {
      //       navService().back();
      //       _permissionCheck = true;
            if (Platform.isAndroid &&
                status == permissionHandler.PermissionStatus.denied) {
              _checkLocationPermission3();
            } else {
              print('permi Nooooo Setting');
              // AppSettings.openAppSettings();
            }
      //     }
      // );
    }
  }




  // Future<void> checkpermittion() async {
  //   // You can request multiple permissions at once.
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.location,
  //     // Permission.camera,
  //     //add more permission to request here.
  //   ].request();
  //
  //   if(statuses[Permission.location].isDenied){ //check each permission status after.
  //     print("Location permission is denied.");
  //   }
  //
  //   // if(statuses[Permission.camera].isDenied){ //check each permission status after.
  //   //   print("Camera permission is denied.");
  //   // }
  //
  // }
  Future<bool> getPrefs() async {

     var sharedPreferences = await SharedPreferences.getInstance();

     if(sharedPreferences.getString(Constant.USERID)==null){
       useriD = false;
       return false;
     }else {
       useriD = true;
       return true;
     }


  }
}
