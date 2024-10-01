import '../export/export.dart';

class ColumnWidget extends StatelessWidget {
  final String date;
  final String image;
  final String temp;
  final Color color;
  final Color color1;
  final String date1;

  const ColumnWidget(
      {super.key,
      required this.date,
      required this.image,
      required this.temp,
      required this.color,
      required this.color1,
      required this.date1});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * .1;
    double width = MediaQuery.of(context).size.width * .1;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: height * .1, vertical: height * .1),
      child: Container(
        width: height * 1,
        // height: 200,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                temp,
                style: TextStyles.textStyle1.copyWith(color: Colors.white),
              ),
              Image(
                image: NetworkImage(image),
                width: width * 2,
                height: height * .5,
              ),
              Text(
                date,
                style: TextStyles.textStyle1.copyWith(color: color1),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                width: width * 2,
                height:
                    height * .28, // Set the width according to your requirement
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: .7, vertical: .5),
                  child: Padding(
                    padding: EdgeInsets.only(left: width*.2),
                    child: Text(
                      date1,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Get.height * .02,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines:
                          1,
                      overflow: TextOverflow
                          .fade,  
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
