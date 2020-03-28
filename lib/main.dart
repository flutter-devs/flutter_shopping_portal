import 'package:flutter/material.dart';
import 'package:myntra_test_app/provider_setup.dart';
import 'package:myntra_test_app/src/res/values/theme.dart';
import 'package:provider/provider.dart';
import 'package:myntra_test_app/src/core/helpers/helper.dart';
import 'package:myntra_test_app/src/core/view_model/auth_provider.dart';
import 'package:myntra_test_app/src/ui/view/home_screen.dart';
import 'package:myntra_test_app/src/ui/view/splash_screen.dart';

// This is the top level function where execution starts
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Helper.dismissKeyboard(ctx: context);
      },
      // Adding providers at the top level of widgets
      child: MultiProvider(
        providers: providers,
        // This indicates that we are using Material property in our app
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          // To disable debug banner
          debugShowCheckedModeBanner: false,
          // To disable debug banner
          home: Consumer<AuthProvider>(
            builder: (ctx, authProvider, _) {
              return authProvider.isAuthorized
                  ? HomeScreen()
                  : FutureBuilder(
                      future: authProvider.tryAutoLogin(),
                      builder: (ctx1, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : HomeScreen();
                      },
                    );
            },
          ),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
          },
        ),
      ),
    );
  }
}
