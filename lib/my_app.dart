import 'package:dev_odyssey/auth_widget_builder.dart';
import 'package:dev_odyssey/models/user_model.dart';
import 'package:dev_odyssey/providers/theme_provider.dart';
import 'package:dev_odyssey/routes.dart';
import 'package:dev_odyssey/theme.dart';
import 'package:flutter/material.dart';
import 'package:dev_odyssey/providers/auth_provider.dart';
import 'package:dev_odyssey/services/firestore_database.dart';
import 'package:dev_odyssey/screens/login.dart';
import 'package:dev_odyssey/screens/home.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({required Key key, required this.databaseBuilder})
      : super(key: key);

  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProviderRef, __) {
        // {context, data, child}
        return AuthWidgetBuilder(
          databaseBuilder: databaseBuilder,
          builder:
              (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: context.toString(),
              routes: Routes.routes,
              theme: AppThemes.lightTheme,
              darkTheme: AppThemes.darkTheme,
              themeMode: themeProviderRef.isDarkModeOn
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: Consumer<AuthProvider>(
                builder: (_, authProviderRef, __) {
                  if (userSnapshot.connectionState == ConnectionState.active) {
                    if (userSnapshot.data!.uid != 'null') {
                      return const HomeScreen();
                    } else {
                      return const LoginScreen();
                    }
                  }
                  return const Material(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            );
          },
          key: const Key('AuthWidget'),
        );
      },
    );
  }
}
