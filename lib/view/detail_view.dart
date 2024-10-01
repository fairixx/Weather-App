import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:weather_flutter_application_15/export/export.dart';

class DetailDaysView extends StatefulWidget {
  final List consolidatedWeatherList;
  final int selectedId;
  final String location;

  const DetailDaysView({
    super.key,
    required this.consolidatedWeatherList,
    required this.selectedId,
    required this.location,
  });

  @override
  State<DetailDaysView> createState() => _DetailDaysViewState();
}

class _DetailDaysViewState extends State<DetailDaysView> {
  String location = 'Lahore';
  Future<ForecastModel> getWeeklyForecast(String location) async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=dae7629a388cf4ee032c9223d7f8237d'));
      var data = jsonDecode(response.body.toString());
      log('Received data: $data');
      if (response.statusCode == 200) {
        log('Received data: $data');

        return ForecastModel.fromJson(data);
      } else {
        throw Exception('Failed to load weekly forecast data');
      }
    } catch (e, stackTrace) {
      log('Error fetching weekly forecast data: $e\n$stackTrace');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    // String imageUrl = '';
    String newDate = 'loading...';

    double height = MediaQuery.of(context).size.height * .1;
    double width = MediaQuery.of(context).size.height * .1;
    // int selectedIndex = widget.selectedId;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xFFA0B0E6),
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              widget.location,
              style: TextStyles.textStyle
                  .copyWith(color: Colors.white, fontSize: 22),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
              padding: const EdgeInsets.only(left: 13.0, top: 11.0),
              child: IconButton(
                onPressed: () {
                  // Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: FutureBuilder<ForecastModel>(
          future: getWeeklyForecast(location),
          builder: (context, snapshot) {
            ForecastModel weatherData = snapshot.data!;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No data available'));
            } else {
              return detailWidget(weatherData, newDate, height, width);
            }
          },
        ));
  }

  Stack detailWidget(
      ForecastModel weatherData, String newDate, double height, double width) {
    return Stack(children: [
      Column(
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: ListView.builder(
              itemCount: weatherData.list!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // WeatherLists weather = weatherData.list![index];
                if (index < weatherData.list!.length) {
                  WeatherLists weather =
                      weatherData.list != null && weatherData.list!.isNotEmpty
                          ? weatherData.list![index]
                          : WeatherLists();
                  // DateTime currentDate = DateTime.parse(weather.dtTxt!);
                  // newDate = DateFormat('EEEE')
                  //     .format(currentDate)
                  //     .substring(0, 3);
                  DateTime currentDate = DateTime.parse(
                      weather.dtTxt ?? DateTime.now().toString());

                  String today = DateTime.now().toString().substring(0, 10);
                  var selectedDay = weather.dtTxt;
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RouteName.listScreen);
                    },
                    child: ColumnWidget(
                      date: newDate,
                      image:
                          'https://openweathermap.org/img/wn/${weather.weather![0].icon}@2x.png',

                      temp: '${weather.main!.temp!.toStringAsFixed(0)}°C',
                      color1: selectedDay == today
                          ? CustomColor.blue
                          : Colors.white,
                      color: selectedDay == today
                          ? Colors.white
                          : CustomColor.blue,
                      // date1: DateFormat('M/d/y').format(currentDate),
                      date1: DateFormat('hh:mm: a').format(currentDate),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          110.ph,
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(95),
                  topRight: Radius.circular(95),
                ),
                color: Colors.white,
              ),
              width: double.infinity,
              // height: double.infinity,
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: height * 4.4,
                        height: height * 3.2,
                        margin: const EdgeInsets.only(left: 15, right: 13),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.center,
                            colors: [
                              CustomColor.blueDark1,
                              CustomColor.blueShadow2
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: CustomColor.blue,
                                blurRadius: 13,
                                offset: Offset(0, 8))
                          ],
                          color: CustomColor.blueDark,
                          borderRadius: BorderRadius.circular(33),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        right: 45,
                        child: Text(
                          '${weatherData.list![0].main?.temp?.toStringAsFixed(0) ?? "N/A"}°C',
                          style: const TextStyle(
                              fontSize: 60, color: Colors.white38),
                        ),
                      ),
                      Positioned(
                        top: 100,
                        left: 35,
                        child: Text(
                          weatherData.list![0].weather![0].description
                              .toString(),
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        top: 120,
                        left: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RowWidget(
                              image: ImagesClass.humidity,
                              unit: '',
                              text: 'Humidity',
                              value: (weatherData.list![0].main!.humidity)!
                                  .toInt(),
                            ),
                            RowWidget(
                              image: ImagesClass.windSpeed,
                              unit: 'km/h',
                              text: 'WindSpeed',
                              value: (weatherData.list![0].wind!.speed)!
                                  .toDouble()
                                  .toStringAsFixed(0),
                            ),
                            RowWidget(
                              image: ImagesClass.maxTemp,
                              unit: 'C',
                              text: 'maxTemp',
                              value: (weatherData.list![0].main!.tempMax)!
                                  .toDouble()
                                  .toStringAsFixed(0),
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   top: 100,
                      //   child: SizedBox(
                      //       height: 400,
                      //       width: double.infinity,
                      //       child: Column(
                      //         children: const [
                      //           Card(
                      //             color: Colors.amber,
                      //             child: ListTile(
                      //               title: Text('data'),
                      //             ),
                      //           ),
                      //         ],
                      //       )),
                      // ),
                      // Positioned(
                      //     top: 300,
                      //     left: 20,
                      //     child: SizedBox(
                      //       height: 200,
                      //       width: height * .9,
                      //       child: ListView.builder(
                      //           scrollDirection: Axis.vertical,
                      //           itemCount: widget.consolidatedWeatherList.length,
                      //           itemBuilder: (BuildContext context, int index) {
                      //             var futureWeatherName =
                      //                 widget.consolidatedWeatherList[index]
                      //                     ['weather_state_name'];
                      //             var futureImageURL = futureWeatherName
                      //                 .replaceAll(' ', '')
                      //                 .toLowerCase();
                      //             var myDate = DateTime.parse(
                      //                 widget.consolidatedWeatherList[index]
                      //                     ['applicable_date']);
                      //             var currentDate =
                      //                 DateFormat('d MMMM, EEEE').format(myDate);
                      //             return Container(
                      //               margin: const EdgeInsets.only(
                      //                   left: 10, top: 10, right: 10, bottom: 5),
                      //               height: 80,
                      //               width: double.infinity,
                      //               decoration: BoxDecoration(
                      //                   color: Colors.white,
                      //                   borderRadius: const BorderRadius.all(
                      //                       Radius.circular(10)),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color:
                      //                           CustomColor.blue.withOpacity(.1),
                      //                       spreadRadius: 5,
                      //                       blurRadius: 20,
                      //                       offset: const Offset(0, 3),
                      //                     ),
                      //                   ]),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(8.0),
                      //                 child: Row(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.center,
                      //                   children: [
                      //                     Text(
                      //                       currentDate,
                      //                       style: const TextStyle(
                      //                         color: Color(0xff6696f5),
                      //                       ),
                      //                     ),
                      //                     Row(
                      //                       children: [
                      //                         Text(
                      //                           widget.consolidatedWeatherList[
                      //                                   index]['max_temp']
                      //                               .round()
                      //                               .toString(),
                      //                           style: const TextStyle(
                      //                             color: Colors.grey,
                      //                             fontSize: 30,
                      //                             fontWeight: FontWeight.w600,
                      //                           ),
                      //                         ),
                      //                         const Text(
                      //                           '/',
                      //                           style: TextStyle(
                      //                             color: Colors.grey,
                      //                             fontSize: 30,
                      //                           ),
                      //                         ),
                      //                         Text(
                      //                           widget.consolidatedWeatherList[
                      //                                   index]['min_temp']
                      //                               .round()
                      //                               .toString(),
                      //                           style: const TextStyle(
                      //                             color: Colors.grey,
                      //                             fontSize: 25,
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                     Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         Image.asset(
                      //                           '${'assets/images/' + futureImageURL}.png',
                      //                           width: 30,
                      //                         ),
                      //                         Text(widget.consolidatedWeatherList[
                      //                             index]['weather_state_name']),
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //               ),
                      //             );
                      //           }),
                      //     ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Positioned(
      //   top: 230,
      //   left: 50,
      //   child: Image(
      //     image: ImagesClass.clear,
      //     width: width * 1.4,
      //     height: height * .3,
      //   ),
      // ),
      buildWeatherIcon(weatherData, width, height),
      // Positioned(
      //   bottom: 20,
      //   left: 0,
      //   child: Container(
      //     color: const Color.fromARGB(255, 130, 68, 68),
      //     height: 200,
      //     width: double.infinity,
      //     child: Image(
      //     image: Imagess.clear,
      //     width: height * 1.4,
      //   ),
      //   ),
      // ),
    ]);
  }

  Widget buildWeatherIcon(ForecastModel weathers, double width, double height) {
    return Positioned(
      top: 45,
      left: 30,
      child: Image.network(
        'https://openweathermap.org/img/wn/${weathers.list![0].weather![0].icon}@4x.png',
        width: width * 2,
        height: height * 2,
      ),
    );
  }
}
