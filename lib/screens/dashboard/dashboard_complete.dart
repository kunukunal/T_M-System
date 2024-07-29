import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/dashboard/search/search_widget.dart';
import 'package:tanent_management/screens/dashboard/tenant/tenant_list/tenant_list_widgets.dart';

class CompleteDashboard extends StatelessWidget {
  const CompleteDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchWidget().occUnoccContainer(
                    icon: occupiedIcon,
                    titleUnit: 'Properties(Units)',
                    units: '600/1200'),
                SizedBox(
                  width: 5.w,
                ),
                SearchWidget().occUnoccContainer(
                    icon: unOccupiedIcon, titleUnit: 'Tenants', units: '600'),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            filterWidget(title: "Income/Expense"),
            SizedBox(height: 16.h),
            OverviewCard(
              title: 'Income/Expense',
              chartTitles: const ['Income', 'Expense'],
              data: const [
                [30, 25, 40, 20],
                [20, 35, 30, 10]
              ],
              colors: const [Colors.blue, Colors.red],
              xLabels: const ['January', 'February', 'March', 'April'],
            ),
            SizedBox(height: 16.h),
            filterWidget(title: 'Occupancy Trend'),
            SizedBox(height: 16.h),
            OverviewCard(
              title: 'Occupancy Trend',
              chartTitles: const ['Rent Paid', 'Rent Due'],
              data: const [
                [25, 30, 35, 20],
                [15, 20, 25, 10]
              ],
              colors: const [Colors.blue, Colors.black],
              xLabels: const ['January', 'February', 'March', 'April'],
            ),
            SizedBox(
              height: 10.h,
            ),
            tenantRentContainer(),
            SizedBox(
              height: 10.h,
            ),
            tenantRentContainer(),
            SizedBox(
              height: 10.h,
            ),
            filterWidget(title: "Properties List"),
            SizedBox(
              height: 10.h,
            ),
            propertiesList(),
          ],
        ),
      ),
    );
  }
}

tenantRentContainer() {
  int totalRent = 100; // Total rent amount
  int paidRent = 200; // Amount of rent paid
  double progress = 0.0;

  if (totalRent > 0) {
    progress = paidRent / totalRent;
  }
  return Container(
    height: 115.h,
    width: double.infinity,
    decoration: BoxDecoration(
        border: Border.all(color: HexColor('#EBEBEB')),
        borderRadius: BorderRadius.circular(10.r)),
    child: Padding(
      padding: EdgeInsets.all(10.r),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rent',
                style: CustomStyles.otpStyle050505W700S16,
              ),
              Row(
                children: [
                  Text(
                    'Month to Month',
                    style: CustomStyles.desc606060
                        .copyWith(fontSize: 14.sp, fontFamily: 'DM Sans'),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  filterIcon
                ],
              )
            ],
          ),
          SizedBox(height: 10.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: HexColor('#D9E3F4'),
            valueColor: AlwaysStoppedAnimation<Color>(HexColor('#679BF1')),
            minHeight: 5.h,
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rent paid',
                    style: CustomStyles.desc606060
                        .copyWith(fontSize: 14.sp, fontFamily: 'DM Sans'),
                  ),
                  Text(
                    '₹${00}',
                    style: CustomStyles.black16,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Due',
                    style: CustomStyles.desc606060
                        .copyWith(fontSize: 14.sp, fontFamily: 'DM Sans'),
                  ),
                  Text(
                    '₹${00}',
                    style: CustomStyles.black16,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ),
  );
}

class OverviewCard extends StatelessWidget {
  final String title;
  final List<String> chartTitles;
  final List<List<int>> data;
  final List<Color> colors;
  final List<String> xLabels;

  OverviewCard({
    required this.title,
    required this.chartTitles,
    required this.data,
    required this.colors,
    required this.xLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.w),
          border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Statistics',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Row(
                children: chartTitles
                    .asMap()
                    .entries
                    .map(
                      (entry) => Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Indicator(
                            color: colors[entry.key], text: entry.value),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 200.h,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                gridData: FlGridData(
                  drawVerticalLine: false,
                ),
                alignment: BarChartAlignment.spaceAround,
                barGroups: _buildBarGroups(),
                titlesData: FlTitlesData(
                  topTitles: SideTitles(showTitles: false),
                  leftTitles: SideTitles(showTitles: true),
                  rightTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                    ),
                    margin: 16.h,
                    getTitles: (double value) {
                      return xLabels[value.toInt()];
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < data[0].length; i++) {
      List<BarChartRodData> rods = [];
      for (int j = 0; j < data.length; j++) {
        rods.add(
          BarChartRodData(
            width: 18,
            y: data[j][i].toDouble(),
            colors: [colors[j]],
          ),
        );
      }
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: rods,
        ),
      );
    }
    return barGroups;
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const Indicator({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.h,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4.w),
        Text(text, style: TextStyle(fontSize: 10.sp)),
      ],
    );
  }
}

propertiesList() {
  return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: HexColor('#EBEBEB')),
              borderRadius: BorderRadius.circular(10.r)),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRect(
                      child: Container(
                        height: 90.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: DecorationImage(
                                image: profileIconWithWidget.image)),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Darlene Robertson",
                                style: CustomStyles.black14,
                              )),
                              Text(
                                "Occupied",
                                style: CustomStyles.amountFA4343W700S12,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 25.r,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Expanded(
                                  child: Text(
                                "4140 Parker Rd. Allentown, New Mexico 31134",
                                style: CustomStyles.address050505w400s12,
                              ))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10.h,
        );
      },
      itemCount: 5);
}

Widget filterWidget({required String title}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: CustomStyles.titleText
            .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
      ),
      Row(
        children: [
          Text(
            'Month',
            style: CustomStyles.titleText
                .copyWith(fontWeight: FontWeight.w500, fontFamily: 'Inter'),
          ),
          SizedBox(
            width: 10.w,
          ),
          Image.asset(
            "assets/icons/filter.png",
            height: 20.h,
            width: 20.w,
          )
        ],
      ),
    ],
  );
}
