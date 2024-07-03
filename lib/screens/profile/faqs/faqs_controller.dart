import 'package:get/get.dart';

class FaqsController extends GetxController{
  //variables
  final quesAnsList = <Map>[
    {
      'ques': 'What is Landlord?',
      'isExpanded': true,
      'ans':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ',
    },
    {
      'ques':
      'How do I add a new tenant tomy property?',
      'isExpanded': false,
      'ans':  'Call 911 in any and all emergency situations.'
    },
    {
      'ques':
      'Can I track rental payments and late fees through the app?',
      'isExpanded': false,
      'ans': 'Please call your facility for any care needs requiring immediate actions.',
    },
    {
      'ques':
      'How do I add a new tenant to my property',
      'isExpanded': false,
      'ans': 'Please call your facility for any care needs requiring immediate actions.',
    },
  ].obs;

}