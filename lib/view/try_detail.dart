import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../export/export.dart';

class DetailDaysViewScreen extends StatefulWidget {
  // final List consolidatedWeatherList;
  // final int selectedId;
  // final String location;
  final ForecastModel forecastModel;
  final WeatherLists weatherLists;
  final double height;
  final String? location;

  const DetailDaysViewScreen({
    super.key,
    required this.forecastModel,
    required this.weatherLists,
    required this.height,
    required this.location,
    // required this.consolidatedWeatherList,
    // required this.selectedId,
    // required this.location,
  });

  @override
  State<DetailDaysViewScreen> createState() => _DetailDaysViewScreenState();
}

class _DetailDaysViewScreenState extends State<DetailDaysViewScreen> {
  // String location = 'Lahore';
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

  var newDate = 'loading...';

  @override
  Widget build(BuildContext context) {
    // String imageUrl = '';
    // String newDate = 'loading...';
    // double height = MediaQuery.of(context).size.height * .1;
    // int selectedIndex = widget.selectedId;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: CustomColor.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Text(
              // location,
              widget.location.toString(),
              style: TextStyles.textStyle
                  .copyWith(color: CustomColor.white, fontSize: 22),
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
              padding: const EdgeInsets.only(left: 13.0, top: 11.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
        body: Stack(children: [
          Column(
            children: [
              SizedBox(
                height: 160,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: widget.forecastModel.list!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index < widget.forecastModel.list!.length) {
                      WeatherLists weather = widget.forecastModel.list![index];
                      DateTime currentDate = DateTime.parse(weather.dtTxt!);
                      newDate = DateFormat('EEEE')
                          .format(currentDate)
                          .substring(0, 3);
                      String today = DateTime.now().toString().substring(0, 10);
                      var selectedDay = weather.dtTxt;
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.listScreen);
                        },
                        child: ColumnWidget(
                          date: newDate,
                          image:
                              'https://openweathermap.org/img/wn/${widget.weatherLists.weather![0].icon}@2x.png',

                          temp:
                              '${widget.weatherLists.main!.temp!.toStringAsFixed(0)}°C',
                          color1: selectedDay == today
                              ? CustomColor.blue
                              : CustomColor.white,
                          color: selectedDay == today
                              ? CustomColor.white
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
                    color: CustomColor.white,
                  ),
                  width: double.infinity,
                  // height: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: widget.height * 4.4,
                        height: widget.height * 3.2,
                        margin: const EdgeInsets.only(left: 15, right: 13),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.center,
                            colors: [Color(0xffa9c1f5), Color(0xff6696f5)],
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: CustomColor.blue,
                                blurRadius: 13,
                                offset: Offset(0, 8))
                          ],
                          color: CustomColor.blueLight,
                          borderRadius: BorderRadius.circular(33),
                        ),
                      ),
                      Positioned(
                        top: 25,
                        right: 45,
                        child: Text(
                          '${widget.forecastModel.list![0].main?.temp?.toStringAsFixed(0) ?? "N/A"}°C',
                          style: const TextStyle(
                              fontSize: 50, color: CustomColor.white38),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 35,
                        child: SizedBox(
                          width: 170,
                          child: Text(
                            widget
                                .forecastModel.list![0].weather![0].description
                                .toString(),
                            style: const TextStyle(
                                fontSize: 28,
                                shadows: [
                                  Shadow(
                                      color: CustomColor.black26,
                                      offset: Offset(5, 5),
                                      blurRadius: 5)
                                ],
                                fontWeight: FontWeight.w900,
                                color: CustomColor.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
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
                              color: CustomColor.white,
                              size: 15,
                              image: ImagesClass.humidity,
                              unit: '',
                              text: 'Humidity',
                              value: (widget
                                      .forecastModel.list![0].main!.humidity)!
                                  .toInt(),
                            ),
                            RowWidget(
                              color: CustomColor.white,
                              size: 15,
                              image: ImagesClass.windSpeed,
                              unit: 'km/h',
                              text: 'WindSpeed',
                              value:
                                  (widget.forecastModel.list![0].wind!.speed)!
                                      .toDouble()
                                      .toStringAsFixed(0),
                            ),
                            RowWidget(
                              size: 15,
                              color: CustomColor.white,
                              image: ImagesClass.maxTemp,
                              unit: 'C',
                              text: 'maxTemp',
                              value:
                                  (widget.forecastModel.list![0].main!.tempMax)!
                                      .toDouble()
                                      .toStringAsFixed(0),
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //     top: 300,
                      //     left: 20,
                      //     child: SizedBox(
                      //       height: 200,
                      //       width: double.infinity,
                      //       child: ListView.builder(
                      //           scrollDirection: Axis.vertical,
                      //           itemCount: widget.forecastModel.list!.length,
                      //           itemBuilder: (BuildContext context, int index) {
                      //             // var futureWeatherName =
                      //             //     widget.consolidatedWeatherList[index]
                      //             //         ['weather_state_name'];
                      //             // var futureImageURL = futureWeatherName
                      //             //     .replaceAll(' ', '')
                      //             //     .toLowerCase();
                      //             DateTime current = DateTime.parse(
                      //                 widget.forecastModel.list![index].dtTxt.toString());
                      //             var newDate =
                      //                 DateFormat('EEEE').format(current).substring(0, 3);
                      //                 // DateFormat('d MMMM, EEEE').format(current);
                      //             return Container(
                      //               margin: const EdgeInsets.only(
                      //                   left: 10,
                      //                   top: 10,
                      //                   right: 10,
                      //                   bottom: 5),
                      //               height: 10,
                      //               width: double.infinity,
                      //               decoration: BoxDecoration(
                      //                   color: const Color.fromARGB(255, 131, 110, 110),
                      //                   borderRadius: const BorderRadius.all(
                      //                       Radius.circular(10)),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: CustomColor.blue
                      //                           .withOpacity(.1),
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
                      //                       'data',
                      //                       // newDate,
                      //                       style: const TextStyle(
                      //                          fontSize: 20,
                      //                         color: Color(0xff6696f5),
                      //                       ),
                      //                     ),
                      //                     // Row(
                      //                     //   children: [
                      //                     //     Text(
                      //                     //       widget.forecastModel
                      //                     //           .list![index].main!.tempMax
                      //                     //           .toString(), // widget.consolidatedWeatherList[
                      //                     //       //         index]['max_temp']
                      //                     //       //     .round()
                      //                     //       //     .toString(),
                      //                     //       style: const TextStyle(
                      //                     //         color: Colors.grey,
                      //                     //         fontSize: 20,
                      //                     //         fontWeight: FontWeight.w600,
                      //                     //       ),
                      //                     //     ),
                      //                     //     const Text(
                      //                     //       '/',
                      //                     //       style: TextStyle(
                      //                     //         color: Colors.grey,
                      //                     //         fontSize: 20,
                      //                     //       ),
                      //                     //     ),
                      //                     //     Text(
                      //                     //       widget.forecastModel
                      //                     //           .list![index].main!.tempMin
                      //                     //           .toString(),
                      //                     //       // widget.consolidatedWeatherList[
                      //                     //       //         index]['min_temp']
                      //                     //       //     .round()
                      //                     //       //     .toString(),
                      //                     //       style: const TextStyle(
                      //                     //         color: Colors.grey,
                      //                     //         fontSize: 20,
                      //                     //       ),
                      //                     //     ),
                      //                     //   ],
                      //                     // ),
                      //                     // Column(
                      //                     //   mainAxisAlignment:
                      //                     //       MainAxisAlignment.center,
                      //                     //   children: [
                      //                     //     Image(
                      //                     //         image: NetworkImage(
                      //                     //       'https://openweathermap.org/img/wn/${widget.forecastModel.list![index].weather![index].icon}@2x.png',
                      //                     //     )),
                      //                     //     Text(widget
                      //                     //         .forecastModel
                      //                     //         .list![index]
                      //                     //         .weather![index]
                      //                     //         .description
                      //                     //         .toString()),
                      //                     //   ],
                      //                     // )
                      //                   ],
                      //                 ),
                      //               ),
                      //             );
                      //           }),
                      //     ))
                    ],
                  ),
                ),
              ),
              Container(
                height: 180,
                width: double.infinity,
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.forecastModel.list!.length,
                  itemBuilder: (BuildContext context, int index) {
                    WeatherLists weather = widget.forecastModel.list![index];

                    var date = DateTime.parse(weather.dtTxt!);
                    newDate =
                        '${DateFormat('EEEE, d MMMM').format(date).substring(0, 3)}, ${DateFormat('h:mm a').format(date)}';
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 4),
                      child: Card(
                        // color: Color.fromARGB(255, 255, 255, 255),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  newDate,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 137, 185, 224),
                                      fontWeight: FontWeight.bold),
                                ),
                                // Spacer(),
                                const Text(
                                  '10/3',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Color.fromARGB(255, 105, 114, 122),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 25,
                                  width: 60,
                                  child: Image(
                                    image: NetworkImage(
                                      'https://openweathermap.org/img/wn/${widget.forecastModel.list![0].weather![0].icon}@2x.png',
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.forecastModel.list![0].weather![0]
                                      .description
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 98, 104, 109),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
              top: 210,
              left: 50,
              child: Image(
                  image: NetworkImage(
                'https://openweathermap.org/img/wn/${widget.forecastModel.list![0].weather![0].icon}@2x.png',
              ))

              // Image(
              //   image: ImagesClass.clear,
              //   width: widget.height * 1.4,
              // ),
              ),
        ]));
  }
}
