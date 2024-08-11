import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/landlord_screens/expense/expense_controller.dart';
import 'package:tanent_management/landlord_screens/expense/expense_widgets.dart';

import '../../common/text_styles.dart';

class ExpenseScreen extends StatelessWidget {
  ExpenseScreen({super.key});

  final expenseCntrl = Get.put(ExpenseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        title: Text('Expense', style: CustomStyles.otpStyle050505),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          expenseCntrl.onAddTap();
        },
        backgroundColor: Colors.white,
        shape: CircleBorder(side: BorderSide(color: HexColor('#EBEBEB'))),
        child: addIcon,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          expenseCntrl.getExpenseData();
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            Divider(
              color: HexColor('#EBEBEB'),
              height: 1.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ExpenseWidgets().dateRangePicker(),
                  ExpenseWidgets().totalExpenseContainer(),
                  ExpenseWidgets().expenseList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
