import 'package:get/get.dart';
import 'package:tanent_management/screens/expense/add_expense/add_expense_view.dart';

class ExpenseController extends GetxController{
  //variables
  final expenseList=<Map>[
    {
      'date':'21\nJan',
      'name':'Expense Name',
      'amount':'₹500.00',
      'type':'Cash',
      'fileName':'Receipt.png',
      'description':'Show expense description here in two lines maximum',
    },
    {
      'date':'10\nJan',
      'name':'Expense Name',
      'amount':'₹1800.00',
      'type':'Credit Card',
      'fileName':'Receipt.png',
      'description':'Show expense description here in two lines maximum',
    },
    {
      'date':'21\nJan',
      'name':'Expense Name',
      'amount':'₹500.00',
      'type':'Cash',
      'fileName':'Receipt.png',
      'description':'Show expense description here in two lines maximum',
    },
  ].obs;

  //Functions
  onAddTap(){
    Get.to(()=>AddExpenseScreen());
  }
}