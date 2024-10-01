
import '../export/export.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    List consolidatedWeatherList = [];
    // ForecastModel foreCastModel;
    // WeatherLists weatherLists;
    // double height;
    // var index = consolidatedWeatherList.length;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const WelcomeView(),
        );
      case RouteName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );
      case RouteName.detailScreen:
        Map<String, dynamic>? args =
            settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => DetailDaysView(
            consolidatedWeatherList: args?[consolidatedWeatherList],
            selectedId: args?['selectedId'],
            location: args?['location'],
          ),
        );
      case RouteName.listScreen:
        return MaterialPageRoute(
          builder: (context) => const ListScreen(),
        );
      // case RouteName.newHomeScreen:
      //   return MaterialPageRoute(
      //     builder: (context) => const HomeScreen(),
      //   );
      default:
        {
          return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(child: Text('NO Routes Defined')),
            ),
          );
        }
    }
  }
}
