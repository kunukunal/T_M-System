import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/screens/dashboard/property/add_property/property_ab/property_ab_controller.dart';
import 'package:tanent_management/screens/dashboard/property/property_list/property_list_controller.dart';
import 'package:tanent_management/screens/dashboard/search/search_widget.dart';

class CompleteDashboard extends StatelessWidget {
  CompleteDashboard({super.key});
  final dashCntrl = Get.find<DashBoardController>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(0.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SearchWidget().occUnoccContainer(
                    icon: occupiedIcon,
                    titleUnit: 'Properties(Units)',
                    units:
                        '${dashCntrl.propertyStats['occupied_units']}/${dashCntrl.propertyStats['total_units']}'),
                SizedBox(
                  width: 5.w,
                ),
                SearchWidget().occUnoccContainer(
                    icon: unOccupiedIcon,
                    titleUnit: 'Tenants',
                    units: '${dashCntrl.propertyStats['tenants']}'),
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
              data: [dashCntrl.income, dashCntrl.expense],
              colors: const [Colors.blue, Colors.red],
              xLabels: dashCntrl.xIncomeExpenseLabels,
            ),
            SizedBox(height: 16.h),
            filterWidget(title: 'Occupancy Trend'),
            SizedBox(height: 16.h),
            OverviewCard(
              title: 'Occupancy Trend',
              chartTitles: const ['Rent Paid', 'Rent Due'],
              data: [dashCntrl.rentPaid, dashCntrl.rentDue],
              colors: const [Colors.blue, Colors.black],
              xLabels: dashCntrl.xOccupancyTrendLabels,
            ),
            SizedBox(
              height: 10.h,
            ),
            tenantRentContainer(),
            SizedBox(
              height: 10.h,
            ),
            tenantRentContainer(isForRent: false),
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

tenantRentContainer({bool isForRent = true}) {
  final dashCntrl = Get.find<DashBoardController>();

  int totalRent = isForRent
      ? dashCntrl.rentBox['total_rent']
      : dashCntrl.expenseBox['upcoming'] +
          dashCntrl.expenseBox['overdue']; // Total rent amount
  int paidRent = isForRent
      ? dashCntrl.rentBox['rent_paid']
      : dashCntrl.expenseBox['upcoming']; // Amount of rent paid
  double progress = 0.0;

  if (totalRent > 0) {
    progress = paidRent / totalRent;
  }
  return Container(
    height: 122.h,
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
                isForRent ? 'Rent' : 'Expense',
                style: CustomStyles.otpStyle050505W700S16,
              ),
              Row(
                children: [
                  Text(
                    'Month to Month',
                    style: CustomStyles.desc606060.copyWith(
                        fontSize: 14.sp - commonFontSize,
                        fontFamily: 'DM Sans'),
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
                    isForRent ? 'Rent paid' : "Upcoming",
                    style: CustomStyles.desc606060.copyWith(
                        fontSize: 14.sp - commonFontSize,
                        fontFamily: 'DM Sans'),
                  ),
                  Text(
                    '₹${isForRent ? dashCntrl.rentBox['rent_paid'] : dashCntrl.expenseBox['upcoming']}',
                    style: CustomStyles.black16,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isForRent ? 'Due' : 'Overdue',
                    style: CustomStyles.desc606060.copyWith(
                        fontSize: 14.sp - commonFontSize,
                        fontFamily: 'DM Sans'),
                  ),
                  Text(
                    '₹${isForRent ? dashCntrl.rentBox['rent_due'] : dashCntrl.expenseBox['overdue']}',
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

  const OverviewCard({
    super.key,
    required this.title,
    required this.chartTitles,
    required this.data,
    required this.colors,
    required this.xLabels,
  });

  bool _isAllDataZero() {
    for (var dataList in data) {
      for (var value in dataList) {
        if (value != 0) {
          return false;
        }
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    bool isDataZero = _isAllDataZero();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        border: Border.all(color: Colors.grey.shade200),
      ),
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
                          color: colors[entry.key],
                          text: entry.value,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 200.h,
            child: isDataZero
                ? Center(
                    child: Text(
                      'No data found',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                  )
                : BarChart(
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
                            fontSize: 12.sp - commonFontSize,
                          ),
                          margin: 16.h,
                          getTitles: (double value) {
                            return xLabels[value.toInt()];
                          },
                        ),
                      ),
                      minY: 0, // Ensure the minimum Y value is 0
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
        double value = data[j][i].toDouble();
        // Ensure the value is not NaN or Infinity
        if (value.isNaN || value.isInfinite) {
          value = 0.0;
        }
        rods.add(
          BarChartRodData(
            width: 18,
            y: value,
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
        Text(text, style: TextStyle(fontSize: 10.sp - commonFontSize)),
      ],
    );
  }
}

propertiesList() {
  final dashCntrl = Get.find<DashBoardController>();
  final propertyCntrl = Get.put(PropertyListController());

  return ListView.separated(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: dashCntrl.proprtyList.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: (){
           propertyCntrl.onItemTap(id:  dashCntrl.proprtyList[index]['id'], propertyTitle: dashCntrl.proprtyList[index]['title']);
        },
        child: Container(
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
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image:
                                dashCntrl.proprtyList[index]['images'].isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            dashCntrl.proprtyList[index]['images']
                                                [0]["image"]),
                                        fit: BoxFit.cover)
                                    : DecorationImage(
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
                                dashCntrl.proprtyList[index]['title'] ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: CustomStyles.black14,
                              )),
                              Text(
                                dashCntrl.proprtyList[index]['status'] ?? "",
                                style: CustomStyles.amountFA4343W700S12.copyWith(
                                    color: dashCntrl.proprtyList[index]
                                                ['status'] ==
                                            "Available"
                                        ? Colors.green
                                        : Colors.red),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
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
                                dashCntrl.proprtyList[index]['address'] ?? "",
                                style: CustomStyles.address050505w400s12,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
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
        ),
      );
    },
    separatorBuilder: (context, index) {
      return SizedBox(
        height: 10.h,
      );
    },
  );
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
