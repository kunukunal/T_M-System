import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/generated/assets.dart';

// Screen -21
class UnitHistory extends StatelessWidget {
  const UnitHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text("Unit History",
            style: CustomStyles.titleText
                .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter')),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            ListTile(
              leading: Image.asset(
                Assets.imagesApartment1Image,
                height: 100.h,
                width: 50.w,
                fit: BoxFit.fill,
              ),
              title: Text(
                "Unit 1",
                style: CustomStyles.titleText
                    .copyWith(fontWeight: FontWeight.w400, fontFamily: 'Inter'),
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Rent Received"),
                  Text("₹ 45,500.00",
                      style: CustomStyles.titleText.copyWith(
                          fontWeight: FontWeight.w400, fontFamily: 'Inter'))
                ],
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
            ),
            Text(
              "Property B | Building1 | Floor 2",
              style: CustomStyles.d7,
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) => historyCard(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Sepreate class

Widget historyCard() {
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(Assets.iconsProfile),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "John Wick",
                          style: CustomStyles.titleText.copyWith(
                              fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                        ),
                        const Text("+91 9898989812")
                      ],
                    ),
                  ],
                ),
                const Text(
                  "₹ 3000.00",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "From",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text("05 Mar 2024",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400))
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("To", style: TextStyle(fontSize: 16)),
                    Text("Present",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.green))
                  ],
                ),
                SizedBox(
                  width: 30.w,
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 10.h,
      )
    ],
  );
}
