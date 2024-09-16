import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/landlord_screens/dashboard/dashboard_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/dashboard_widgets.dart';
import 'package:tanent_management/landlord_screens/dashboard/property/property_list/property_list_controller.dart';
import 'package:tanent_management/landlord_screens/dashboard/search/search_widget.dart';

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
                    titleUnit: 'properties_units'.tr,
                    units:
                        '${dashCntrl.propertyStats['occupied_units']}/${dashCntrl.propertyStats['total_units']}'),
                SizedBox(
                  width: 5.w,
                ),
                SearchWidget().occUnoccContainer(
                    icon: unOccupiedIcon,
                    titleUnit: 'tenants'.tr,
                    units: '${dashCntrl.propertyStats['tenants']}'),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(() {
              return filterWidget(
                  title: "income_expense".tr,
                  startDateTap: () async {
                    final picked = await dashCntrl
                        .selectDate(dashCntrl.incomingStartFrom.value);

                    if (picked != null) {
                      dashCntrl.incomingStartFrom.value = picked;
                    }
                  },
                  endDateTap: () async {
                    final picked = await dashCntrl
                        .selectDate(dashCntrl.incomingEndFrom.value);

                    if (picked != null) {
                      dashCntrl.incomingEndFrom.value = picked;
                    }
                  },
                  searchTap: () {
                    dashCntrl.searchIncomeExpenseByDates();
                  },
                  startText: dashCntrl.incomingStartFrom.value == null
                      ? ""
                      : "${dashCntrl.incomingStartFrom.value?.month}/${dashCntrl.incomingStartFrom.value?.year}",
                  endText: dashCntrl.incomingEndFrom.value == null
                      ? ""
                      : "${dashCntrl.incomingEndFrom.value?.month}/${dashCntrl.incomingEndFrom.value?.year}",
                  isMultipleDate: true);
            }),
            SizedBox(height: 16.h),
            OverviewCard(
              title: 'income_expense'.tr,
              chartTitles: const ['Income', 'Expense'],
              data: [dashCntrl.income, dashCntrl.expense],
              colors: const [Colors.blue, Colors.red],
              xLabels: dashCntrl.xIncomeExpenseLabels,
            ),
            SizedBox(height: 16.h),
            Obx(() {
              return filterWidget(
                  title: 'occupancy_trend'.tr,
                  startDateTap: () async {
                    final picked = await dashCntrl
                        .selectDate(dashCntrl.occupancyStartFrom.value);

                    if (picked != null) {
                      dashCntrl.occupancyStartFrom.value = picked;
                    }
                  },
                  endDateTap: () async {
                    final picked = await dashCntrl
                        .selectDate(dashCntrl.occupancyEndFrom.value);

                    if (picked != null) {
                      dashCntrl.occupancyEndFrom.value = picked;
                    }
                  },
                  searchTap: () {
                    dashCntrl.searchOccupyTreadByDates();
                  },
                  startText: dashCntrl.occupancyStartFrom.value == null
                      ? ""
                      : "${dashCntrl.occupancyStartFrom.value?.month}/${dashCntrl.occupancyStartFrom.value?.year}",
                  endText: dashCntrl.occupancyEndFrom.value == null
                      ? ""
                      : "${dashCntrl.occupancyEndFrom.value?.month}/${dashCntrl.occupancyEndFrom.value?.year}",
                  isMultipleDate: true);
            }),
            SizedBox(height: 16.h),
            OverviewCard(
              title: 'occupancy_trend'.tr,
              chartTitles: const ['Rent Paid', 'Rent Due'],
              data: [dashCntrl.rentPaid, dashCntrl.rentDue],
              colors: const [Colors.blue, Colors.black],
              xLabels: dashCntrl.xOccupancyTrendLabels,
            ),
            SizedBox(
              height: 10.h,
            ),
            DashBoardWidgets().totalExpenseContainer(),
            SizedBox(
              height: 10.h,
            ),
            tenantRentContainer(),
            SizedBox(
              height: 10.h,
            ),
            filterWidget(
                title: "property_list".tr, endDateTap: () {}, endText: ""),
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
  num tRent = dashCntrl.rentBox['total_rent'];

  int totalRent = tRent.toInt(); // Total rent amount
  num pRent = dashCntrl.rentBox['rent_paid'];
  int paidRent = pRent.toInt();
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
                isForRent ? 'rent'.tr : 'expense'.tr,
                style: CustomStyles.otpStyle050505W700S16,
              ),
              Row(
                children: [
                  Text(
                    'month_to_month'.tr,
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
                    isForRent ? 'rent_paid'.tr : "upcoming".tr,
                    style: CustomStyles.desc606060.copyWith(
                        fontSize: 14.sp - commonFontSize,
                        fontFamily: 'DM Sans'),
                  ),
                  Text(
                    '₹${dashCntrl.rentBox['rent_paid']}',
                    style: CustomStyles.black16,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    isForRent ? 'due'.tr : 'overdue'.tr,
                    style: CustomStyles.desc606060.copyWith(
                        fontSize: 14.sp - commonFontSize,
                        fontFamily: 'DM Sans'),
                  ),
                  Text(
                    '₹${dashCntrl.rentBox['rent_due']}',
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
  final dynamic data;
  final List<Color> colors;
  final dynamic xLabels;

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
              Text(
                'statistics'.tr,
                style: const TextStyle(
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
                      'no_data_found'.tr,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                  )
                : Obx(() {
                    return BarChart(
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
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp - commonFontSize,
                            ),
                          ),
                          rightTitles: SideTitles(showTitles: false),
                          bottomTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 10,
                            getTextStyles: (context, value) => TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp - commonFontSize,
                            ),
                            margin: 16.h,
                            getTitles: (double value) {
                              // Ensure the value is within the valid range of xLabels
                              int index = value.toInt();
                              if (index < 0 || index >= xLabels.value.length) {
                                return ''; // Return an empty string if index is out of range
                              }

                              // Return the first 3 letters of the label if it exists
                              String label = xLabels.value[index];
                              return label.length > 3
                                  ? label.substring(0, 3)
                                  : label;
                            },
                          ),
                        ),
                        minY: 0, // Ensure the minimum Y value is 0
                      ),
                    );
                  }),
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
            width: 5,
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
        onTap: () {
          propertyCntrl.onItemTap(
              id: dashCntrl.proprtyList[index]['id'],
              propertyTitle: dashCntrl.proprtyList[index]['title']);
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
                            image: dashCntrl
                                    .proprtyList[index]['images'].isNotEmpty
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
                                style: CustomStyles.amountFA4343W700S12
                                    .copyWith(
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

Widget filterWidget(
    {required String title,
    String startText = "",
    String endText = "",
    VoidCallback? startDateTap,
    VoidCallback? endDateTap,
    VoidCallback? searchTap,
    bool isMultipleDate = false}) {
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
          if (isMultipleDate)
            GestureDetector(
              onTap: startDateTap,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    startText != "" ? startText : ('month'.tr),
                    style: CustomStyles.titleText.copyWith(
                        fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                  ),
                ),
              ),
            ),
          SizedBox(
            width: 2.w,
          ),
          GestureDetector(
            onTap: endDateTap,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  endText != "" ? endText : ('month'.tr),
                  style: CustomStyles.titleText.copyWith(
                      fontWeight: FontWeight.w500, fontFamily: 'Inter'),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          if (isMultipleDate)
            GestureDetector(onTap: searchTap, child: searchIcon)
          else
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
