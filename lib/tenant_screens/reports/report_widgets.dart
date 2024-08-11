import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanent_management/common/text_styles.dart';

class ReportTenantWidget {
  List<BarChartGroupData> buildBarGroups(
      final List<int> data, final List<int>? data2) {
    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < data.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              y: data[i].toDouble(),
              width: 15,
              colors: [Colors.blue],
            ),
            if (data2 != null)
              BarChartRodData(
                width: 15,
                y: data2[i].toDouble(),
                colors: [Colors.blue.shade100],
              ),
          ],
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

class OverviewCard extends StatelessWidget {
  final String chartTitle;
  final String? chartTitle2;
  final List<int> data;
  final List<int>? data2;
  final List<String> xLabels;

  const OverviewCard({
    super.key,
    required this.chartTitle,
    this.chartTitle2,
    required this.data,
    this.data2,
    required this.xLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.w),
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade200)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
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
                children: [
                  if (chartTitle2 != null) ...[
                    Indicator(color: Colors.blue, text: chartTitle),
                    SizedBox(width: 8.w),
                    Indicator(color: Colors.blue.shade100, text: chartTitle2!),
                  ] else ...[
                    Indicator(color: Colors.blue, text: chartTitle),
                  ]
                ],
              ),
            ],
          ),
          SizedBox(height: 25.h),
          SizedBox(
            height: 200.h,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                gridData: FlGridData(drawVerticalLine: false),
                alignment: BarChartAlignment.spaceAround,
                barGroups: ReportTenantWidget().buildBarGroups(data, data2),
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(showTitles: true),
                  topTitles: SideTitles(showTitles: false),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
