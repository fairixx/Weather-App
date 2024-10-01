import '../export/export.dart';

class GlobalController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;

  RxBool checkLoading() => isLoading;
  RxDouble getLatitude() => latitude;
  RxDouble getLongitude() => longitude;

  @override
  void onInit() {
    if (isLoading.isTrue) {
      getLocator();
    }
    super.onInit();
  }

  getLocator() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    } else if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      latitude.value = value.altitude;
      longitude.value = value.latitude;
      isLoading.value = false;
    });
  }
}
