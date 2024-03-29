import 'package:dev_odyssey/screens/about.dart';
import 'package:dev_odyssey/screens/explore.dart';
import 'package:dev_odyssey/screens/friends.dart';
import 'package:dev_odyssey/screens/home.dart';
import 'package:dev_odyssey/screens/login.dart';
import 'package:dev_odyssey/screens/odyssey/odyssey.dart';
import 'package:dev_odyssey/screens/odyssey/odysseys.dart';
import 'package:dev_odyssey/screens/odyssey/people.dart';
import 'package:dev_odyssey/screens/odyssey/resources.dart';
import 'package:dev_odyssey/screens/profile.dart';
import 'package:dev_odyssey/screens/register.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  static const String home = '/home';
  static const String about = '/about';
  static const String login = '/login';
  static const String explore = '/explore';
  static const String odysseys = '/odysseys';
  static const String odyssey = '/odyssey';
  static const String profile = '/profile';
  static const String friends = '/friends';
  static const String resources = '/resources';
  static const String people = '/people';
  static const String register = '/register';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => const HomeScreen(),
    about: (BuildContext context) => const AboutScreen(),
    login: (BuildContext context) => const LoginScreen(),
    explore: (BuildContext context) => const ExploreScreen(),
    odysseys: (BuildContext context) => const OdysseysScreen(),
    odyssey: (BuildContext context) {
      final bool isOwner = ModalRoute.of(context)!.settings.arguments as bool;
      return OdysseyScreen(isOwner: isOwner);
    },
    profile: (BuildContext context) {
      final String userId =
          ModalRoute.of(context)!.settings.arguments as String;
      return ProfileScreen(userId: userId);
    },
    friends: (BuildContext context) => const FriendsScreen(),
    resources: (BuildContext context) => const ResourcesScreen(),
    people: (BuildContext context) => const PeopleScreen(),
    register: (BuildContext context) => const RegisterScreen(),
  };
}
