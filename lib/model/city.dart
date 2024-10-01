class CityModel {
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;

  CityModel(
      {required this.isSelected,
      required this.city,
      required this.country,
      required this.isDefault});

  //List of Cities data
  static List<CityModel> citiesList = [
    CityModel(
        isSelected: false,
        city: 'Lahore',
        country: 'Pakistan',
        isDefault: true),
    CityModel(
        isSelected: false,
        city: 'London',
        country: 'United Kindgom',
        isDefault: true),
    CityModel(
        isSelected: false, city: 'Tokyo', country: 'Japan', isDefault: false),
    CityModel(
        isSelected: false, city: 'Delhi', country: 'India', isDefault: false),
    CityModel(
        isSelected: false, city: 'Beijing', country: 'China', isDefault: false),
    CityModel(
        isSelected: false, city: 'Paris', country: 'Paris', isDefault: false),
    CityModel(
        isSelected: false, city: 'Rome', country: 'Italy', isDefault: false),
    CityModel(
        isSelected: false, city: 'Lagos', country: 'Nigeria', isDefault: false),
    CityModel(
        isSelected: false,
        city: 'Amsterdam',
        country: 'Netherlands',
        isDefault: false),
    CityModel(
        isSelected: false,
        city: 'Barcelona',
        country: 'Spain',
        isDefault: false),
    CityModel(
        isSelected: false,
        city: 'Miami',
        country: 'United States',
        isDefault: false),
    CityModel(
        isSelected: false,
        city: 'Vienna',
        country: 'Austria',
        isDefault: false),
    CityModel(
        isSelected: false,
        city: 'Berlin',
        country: 'Germany',
        isDefault: false),
    CityModel(
        isSelected: false,
        city: 'Toronto',
        country: 'Canada',
        isDefault: false),
    CityModel(
        isSelected: false,
        city: 'Brussels',
        country: 'Belgium',
        isDefault: false),
    CityModel(
        isSelected: false, city: 'Nairobi', country: 'Kenya', isDefault: false),
  ];

  //Get the selected cities
  static List<CityModel> getSelectedCities() {
    List<CityModel> selectedCities = CityModel.citiesList;
    return selectedCities.where((city) => city.isSelected == true).toList();
  }
}
