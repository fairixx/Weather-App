
import '../export/export.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage('assets/image/get-started.png'),
            width: MediaQuery.of(context).size.height * .5,
          ),
          30.ph,
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteName.listScreen);
              // Navigator.pushNamed(context, RouteName.newHomeScreen);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: CustomColor.blue,
                minimumSize: const Size(300, 50)),
            child: const Text('GET STARTED'),
          ),
        ],
      ),
    );
  }
}
