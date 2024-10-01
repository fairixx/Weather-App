import 'dart:math';
import 'package:weather_flutter_application_15/export/export.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    List<CityModel> cities =
        CityModel.citiesList.where((city) => city.isDefault == false).toList();
    List<CityModel> selectedCities = CityModel.getSelectedCities();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: CustomColor.blue,
          title: Text('${selectedCities.length} Select Cities'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7.0, horizontal: 6),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: CustomColor.blue,
                      border: Border.all(
                          color: cities[index].isSelected == true
                              ? Colors.blue
                              : Colors.white,
                          width: 1.7),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x3B3B3845),
                            blurRadius: 2,
                            offset: Offset(2, 4)),
                      ],
                    ),
                    child: ListTile(
                      leading: InkWell(
                        onTap: () {
                          setState(() {
                            cities[index].isSelected =
                                !cities[index].isSelected;
                          });
                        },
                        child: Image(
                          image: cities[index].isSelected == true
                              ? ImagesClass.checked
                              : ImagesClass.unchecked,
                          width: 30,
                        ),
                      ),
                      title: Text(cities[index].city),
                    ),
                  ),
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: CustomColor.blue,
          onPressed: () {
            log(selectedCities.length);
            Navigator.pushNamed(context, RouteName.homeScreen);
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
