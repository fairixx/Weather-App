import 'package:weather_flutter_application_15/export/export.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
      // home: const MyHomePage(title: 'WebRTC	using	Flutter'),
      // home: const DetailDaysView(consolidatedWeatherList: consolidatedWeatherList, selectedId: selectedId, location: location),
    );
  }
}
