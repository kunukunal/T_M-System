import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PropertyDetailViewController extends GetxController{
  final selectedProperty ='Property 1'.obs;
  final propertyList=[
    'Property 1',
    'Property 2',
    'Property 2',
  ].obs;
  final pageController = PageController().obs;
  final initialPage = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    pageController.value.addListener(() {
      initialPage.value= pageController.value.page!.round();
    });
    super.onInit();
  }
}