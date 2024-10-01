

import '../export/export.dart';

class RowWidget extends StatelessWidget {
  final AssetImage image;
  final String text;
  final String unit;
  final double size;
  final Color color;
  final value;

  const RowWidget({
    super.key,
    required this.image,
    required this.text,
    required this.unit,
    required this.value,  this.size=18,  this.color=Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * .1;
    return Padding(
      padding: const EdgeInsets.only(left: 33.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: size,
              color: color
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: height * .7,
              height: height * .7,
              decoration: BoxDecoration(
                color: CustomColor.blue,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: image,
                ),
              ),
            ),
          ),
          Text(
            '$value $unit',
            style: TextStyles.textStyle1.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
