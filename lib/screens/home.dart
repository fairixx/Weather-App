// // ------------------------------------------------------------------

// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:weather_flutter_application_15/Utils/const/color.dart';
// import 'package:weather_flutter_application_15/Utils/const/image.dart';
// import 'package:weather_flutter_application_15/controller/global_controller.dart';
// import 'package:weather_flutter_application_15/model/city.dart';
// import 'package:weather_flutter_application_15/model/forecast.dart';
// import 'package:weather_flutter_application_15/view/try_detail.dart';
// import '../widget/day_widget.dart';
// import '../widget/temp_widget.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final GlobalController globalController =
//       Get.put(GlobalController(), permanent: true);
//   String location = 'Lahore';
//   var newDate = 'loading...';

//   List<CityModel> selectedCities = CityModel.getSelectedCities();
//   List<String> cities1 = ['Lahore'];

//   Future<ForecastModel> getWeeklyForecast(String location) async {
//     try {
//       final response = await http.get(Uri.parse(
//           'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=dae7629a388cf4ee032c9223d7f8237d'));
//       var data = jsonDecode(response.body.toString());
//       log('Received data: $data');
//       if (response.statusCode == 200) {
//         log('Received data: $data');

//         return ForecastModel.fromJson(data);
//       } else {
//         throw Exception('Failed to load weekly forecast data');
//       }
//     } catch (e, stackTrace) {
//       log('Error fetching weekly forecast data: $e\n$stackTrace');
//       rethrow;
//     }
//   }

//   String location1 = '';

//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < selectedCities.length; i++) {
//       cities1.add(selectedCities[i].city);
//       geoCoding(globalController.getLatitude().value,
//           globalController.getLongitude().value);
//     }
//   }

//   geoCoding(lat, log) async {
//     List<Placemark> placemark = await placemarkFromCoordinates(lat, log);
//     log(placemark);
//     Placemark place = placemark[0];
//     setState(() {
//       location1 = place.locality!;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height * .1;

//     return Scaffold(
//       appBar: buildAppBar(height),
//       body: SafeArea(
//         child: Obx(() => globalController.checkLoading().isTrue?const Center(
//                     child: CircularProgressIndicator(),
//                   ):SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                       child: buildWeatherStack(forecastModel, height),
//                     ),
//                   ))
        
        
//       )
//     );
//   }

//   PreferredSizeWidget buildAppBar(double height) {
//     return AppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       leading: buildProfileContainer(height),
//       actions: [
//         Image(
//           image: ImagesClass.pin,
//           width: height * .33,
//         ),
//         buildLocationDropdownButton(),
//         SizedBox(width: height * .1),
//       ],
//     );
//   }

//   Widget buildProfileContainer(double height) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 13.0, top: 11.0),
//       child: Container(
//         height: 70,
//         width: 70,
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           shape: BoxShape.rectangle,
//           image: DecorationImage(image: ImagesClass.profile, fit: BoxFit.fill),
//         ),
//       ),
//     );
//   }

//   Widget buildLocationDropdownButton() {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton(
//         value: location,
//         icon: const Icon(
//           Icons.keyboard_arrow_down,
//           size: 40,
//         ),
//         items: cities1.map((String location) {
//           return DropdownMenuItem(
//             value: location,
//             child: Text(
//               location,
//               style: const TextStyle(fontSize: 19, color: Colors.black),
//             ),
//           );
//         }).toList(),
//         onChanged: (String? newValue) {
//           setState(() {
//             location = newValue ?? 'Lahore';
//             getWeeklyForecast(location);
//           });
//         },
//       ),
//     );
//   }

//   Widget buildWeatherStack(ForecastModel weathers, double height) {
//     // DateTime date = DateTime.now();
//     return Stack(
//       children: [
//         buildWeatherColumn(weathers, height),
//         buildWeatherIcon(weathers, height),
//       ],
//     );
//   }

//   Widget buildWeatherColumn(ForecastModel weathers, double height) {
//     WeatherLists weather = weathers.list![1];

//     var date = DateTime.parse(weather.dtTxt!);
//     newDate =
//         '${DateFormat('EEEE, d MMMM').format(date).substring(0, 3)}, ${DateFormat('h:mm a').format(date)}';
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 20),
//         Text(
//           location1,
//           style: TextStyles.textStyle,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               newDate,
//               style: TextStyles.textStyle1,
//             ),
//             Text(
//               DateFormat('M/d/y').format(date),
//               style: TextStyles.textStyle1,
//             ),
//           ],
//         ),
//         const SizedBox(height: 35),
//         buildWeatherContainer(weathers, height),
//         const SizedBox(height: 10),
//         buildRowWidgetContainer(weathers),
//         const SizedBox(height: 20),
//         buildDateRow(),
//         buildForecastContainer(weathers, height),
//       ],
//     );
//   }

//   Widget buildWeatherContainer(ForecastModel weathers, double height) {
//     return Stack(
//       children: [
//         Container(
//           width: height * 5,
//           height: height * 2.3,
//           decoration: BoxDecoration(
//             boxShadow: const [
//               BoxShadow(
//                 color: CustomColor.blueLight,
//                 blurRadius: 13,
//                 offset: Offset(0, 8),
//               ),
//             ],
//             color: CustomColor.blue,
//             borderRadius: BorderRadius.circular(33),
//           ),
//         ),
//         Positioned(
//           top: 30,
//           right: 45,
//           child: Text(
//             '${weathers.list![0].main!.temp!.toStringAsFixed(0)}°',
//             style: const TextStyle(
//               fontSize: 60,
//               color: CustomColor.white38,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 30,
//           left: 45,
//           child: Text(
//             weathers.list![0].weather![0].description.toString(),
//             style: TextStyles.textStyle.copyWith(color: CustomColor.white),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildRowWidgetContainer(ForecastModel weathers) {
//     return SizedBox(
//       height: 170,
//       width: double.infinity,
//       child: Row(
//         children: [
//           RowWidget(
//             image: ImagesClass.humidity,
//             unit: '',
//             text: 'Humidity',
//             value: (weathers.list![0].main!.humidity)!.toInt(),
//           ),
//           RowWidget(
//             image: ImagesClass.windSpeed,
//             unit: 'km/h',
//             text: 'WindSpeed',
//             value:
//                 (weathers.list![0].wind!.speed)!.toDouble().toStringAsFixed(0),
//           ),
//           RowWidget(
//             image: ImagesClass.maxTemp,
//             unit: 'C',
//             text: 'maxTemp',
//             value: (weathers.list![0].main!.tempMax)!
//                 .toDouble()
//                 .toStringAsFixed(0),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildDateRow() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Today',
//             style: TextStyles.textStyle,
//           ),
//           InkWell(
//             onTap: () {},
//             child: Text(
//               'Next 7 days',
//               style: TextStyles.textStyle.copyWith(
//                 fontWeight: FontWeight.normal,
//                 color: CustomColor.blueDark,
//                 fontSize: 22,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildForecastContainer(ForecastModel weeklyForecast, double height) {
//     return Container(
//       color: CustomColor.white12,
//       height: 160,
//       width: double.infinity,
//       child: ListView.builder(
//         // itemCount: 7,
//         itemCount: weeklyForecast.list!.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           // DateTime currentDate = date.add(Duration(days: index));
//           if (index < weeklyForecast.list!.length) {
//             WeatherLists weather = weeklyForecast.list![index];
//             DateTime currentDate = DateTime.parse(weather.dtTxt!);
//             newDate = DateFormat('EEEE').format(currentDate).substring(0, 3);
//             String today = DateTime.now().toString().substring(0, 10);
//             var selectedDay = weather.dtTxt;
//             return InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => DetailDaysViewScreen(
//                             forecastModel: weeklyForecast,
//                             weatherLists: weather,
//                             height: height)));
//                 // Navigator.pushNamed(
//                 //   context,
//                 //   RouteName.detailScreen,
//                 //   arguments: {
//                 //     'consolidatedWeatherList': weather.dt,
//                 //     'selectedId': index,
//                 //     'location': location,
//                 //   },
//                 // );
//               },
//               child: ColumnWidget(
//                 // date: DateFormat('EEEE').format(date).substring(0, 3),
//                 // image:
//                 //     'https://openweathermap.org/img/wn/${weathers.weather![0].icon}@4x.png',
//                 // temp: '${weathers.main!.temp!.toStringAsFixed(0)}°C',
//                 date: newDate,
//                 image:
//                     'https://openweathermap.org/img/wn/${weather.weather![0].icon}@2x.png',

//                 temp: '${weather.main!.temp!.toStringAsFixed(0)}°C',
//                 color1:
//                     selectedDay == today ? CustomColor.blue : CustomColor.white,
//                 color:
//                     selectedDay == today ? CustomColor.white : CustomColor.blue,
//                 // date1: DateFormat('M/d/y').format(currentDate),
//                 date1: DateFormat('hh:mm: a').format(currentDate),
//               ),
//             );
//           }
//           return null;
//         },
//       ),
//     );
//   }

//   Widget buildWeatherIcon(ForecastModel weathers, double height) {
//     return Positioned(
//       top: 45,
//       left: 30,
//       child: Image.network(
//         'https://openweathermap.org/img/wn/${weathers.list![0].weather![0].icon}@4x.png',
//         width: height * 2,
//       ),
//     );
//   }
// }
