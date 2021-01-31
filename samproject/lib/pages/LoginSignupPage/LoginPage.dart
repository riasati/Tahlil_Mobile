import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'MenuBar/MenuBar.dart';
import 'SignIn/SignInPage.dart';
import 'SignUp/SignUpPage.dart';

class LoginPage extends StatefulWidget {
  final callHomePageBiuld;

  LoginPage( {@required void toggleCoinCallback() }):
        callHomePageBiuld = toggleCoinCallback;

  static PageController pageController = PageController(
    initialPage: 0,
  );
  static Color left = Colors.white;
  static Color right = Colors.black;
  static bool loading = false;

  @override
  _LoginPageState createState() => _LoginPageState(toggleCoinCallback: callHomePageBiuld);
}

class _LoginPageState extends State<LoginPage> {

  final callHomePageBiuld;
  _LoginPageState( {@required void toggleCoinCallback() }):
        callHomePageBiuld = toggleCoinCallback;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LoadingOverlay(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height >= 775.0
                  ? MediaQuery.of(context).size.height
                  : 775.0 ,
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      // Theme.Colors.loginGradientStart,
                      // Theme.Colors.loginGradientEnd
                      Colors.white,
                      Colors.white,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),

              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex:3,
                    child: Padding(
                      padding: EdgeInsets.only(top:0 ),
                      child: new Image(
                        // width: 250.0,
                        // height: 191.0,
                          fit: BoxFit.fill,
                          image: new AssetImage('assets/img/login_logo.jpg')),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: MenuBar(),
                  ),
                  Expanded(
                    flex:5,
                    child: PageView(
                      controller: LoginPage.pageController,
                      onPageChanged: (i) {
                        if (i == 0) {
                          setState(() {
                            LoginPage.right = Colors.black;
                            LoginPage.left = Colors.white;
                          });
                        } else if (i == 1) {
                          setState(() {
                            LoginPage.right = Colors.white;
                            LoginPage.left = Colors.black;
                          });
                        }
                      },
                      children: <Widget>[
                        new ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: SignInPage(toggleCoinCallback: callHomePageBiuld,),
                        ),
                        new ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: SignUpPage(toggleCoinCallback: callHomePageBiuld,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading: LoginPage.loading,
          opacity: 0.6,
          progressIndicator: const CircularProgressIndicator(),
        ),
      ),
    );
  }

  callBuild(){
    widget?.callHomePageBiuld();
  }
}
