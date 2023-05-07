import 'package:dev_odyssey/about/about.dart';
import 'package:dev_odyssey/explore/explore.dart';
import 'package:dev_odyssey/friends/friends.dart';
import 'package:dev_odyssey/home/home.dart';
import 'package:dev_odyssey/login/login.dart';
import 'package:dev_odyssey/odyssey/odyssey.dart';
import 'package:dev_odyssey/profile/profile.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/about': (context) => const AboutScreen(),
  '/login': (context) => const LoginScreen(),
  '/explore': (context) => const ExploreScreen(),
  '/odyssey': (context) => const OdysseyScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/friends': (context) => const FriendsScreen(),
};
