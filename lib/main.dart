import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:myntra_test_app/src/core/blocs/item_detail_bloc.dart';
import 'package:myntra_test_app/src/core/helpers/helper.dart';
import 'package:myntra_test_app/src/core/view_model/auth_provider.dart';
import 'package:myntra_test_app/src/core/view_model/category_provider.dart';
import 'package:myntra_test_app/src/core/view_model/product_provider.dart';
import 'package:myntra_test_app/src/core/view_model/products_provider.dart';
import 'package:myntra_test_app/src/ui/view/home_screen.dart';
import 'package:myntra_test_app/src/ui/view/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MaterialColor white = const MaterialColor(
    0xFFFFFFFF,
    const <int, Color>{
      50: const Color(0xFFFFFFFF),
      100: const Color(0xFFFFFFFF),
      200: const Color(0xFFFFFFFF),
      300: const Color(0xFFFFFFFF),
      400: const Color(0xFFFFFFFF),
      500: const Color(0xFFFFFFFF),
      600: const Color(0xFFFFFFFF),
      700: const Color(0xFFFFFFFF),
      800: const Color(0xFFFFFFFF),
      900: const Color(0xFFFFFFFF),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Helper.dismissKeyboard(ctx: context);
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => CategoryProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ProductsProvider(),
          ),
          Provider(
            create: (_) => ItemDetailBloc(),
          ),
          ChangeNotifierProxyProvider<AuthProvider, ProductProvider>(
            update: (_, authProvider, productProvider) => productProvider
              ..userID = authProvider.getUserID
              ..userDocID = authProvider.getUserDocID,
            create: (_) => ProductProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: white, accentColor: Colors.grey),
          debugShowCheckedModeBanner: false,
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
