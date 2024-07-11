import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/screens/onboarding/auth/login_view/auth_controller.dart';
import '../../../common/constants.dart';
import '../../../common/text_styles.dart';
import '../../../common/widgets.dart';
import '../../onboarding/auth/personal_info/personal_info_widget.dart';
import '../../profile/edit_profile/edit_profile_widget.dart';
import 'management_controller.dart';
import 'management_widgets.dart';

class ManagementScreen extends StatelessWidget {
  final bool isFromDashboard;
   ManagementScreen({required this.isFromDashboard, super.key});

   final manageCntrl = Get.put(ManagementController());
   final authCntrl = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: ()=>Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: backArrowImage,
          ),
        ),
        title: Text('Management', style: CustomStyles.otpStyle050505W700S16),

      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Divider(color:HexColor('#EBEBEB'),height: 1.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 5.h),
            child: Obx(
                    () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                   isFromDashboard?const SizedBox():   Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                                 InkWell(
                                  onTap: (){
                                  },
                                  child:  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Container(
                                      height: 60.h,
                                      width: 70.w,
                                      decoration:  BoxDecoration(
                                        color: HexColor('#444444'),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image:
                                          Image.asset('assets/icons/profile.png')
                                              .image,
                                          fit: BoxFit.cover)
                                    ),
                                  ))),
                          Expanded(
                            child: Padding(

                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                PersonlInfoWidget.commomText('Mobile',isMandatory: true),
                                customTextField(
                                    maxLength: 10,
                                    // width: 200.w,
                                    isForCountryCode: true,
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: HexColor('#6D6E6F'),
                                    ),
                                    hintText: 'Enter Mobile No.',
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.number,
                                    isBorder: true,
                                    isFilled: false
                                ),
                              ],),
                            ),
                          )



                        ],
                      ),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Tenant'),
                      bigDropDown(selectedItem: manageCntrl.selectedTenantName.value, items: manageCntrl.tenantList.value, onChange: (item){
                        manageCntrl.selectedTenantName.value=item;
                      }),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Project'),
                      bigDropDown(selectedItem: manageCntrl.selectedProjectName.value, items: manageCntrl.projectsList.value, onChange: (item){
                        manageCntrl.selectedProjectName.value=item;
                      }),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Tower'),
                      bigDropDown(selectedItem: manageCntrl.selectedTowerName.value, items: manageCntrl.towerList.value, onChange: (item){
                        manageCntrl.selectedTowerName.value=item;
                      }),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Floor'),
                      bigDropDown(selectedItem: manageCntrl.selectedFloorName.value, items: manageCntrl.floorList.value, onChange: (item){
                        manageCntrl.selectedFloorName.value=item;
                      }),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Unit'),
                      bigDropDown(selectedItem: manageCntrl.selectedUnitName.value, items: manageCntrl.unitList.value, onChange: (item){
                        manageCntrl.selectedUnitName.value=item;
                      }),
                      SizedBox(height: 5.h,),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EditProfileWidget.commomText('Rent (Rs)',isMandatory: true),
                              customTextField(
                                keyboardType: TextInputType.phone,
                                controller: manageCntrl.amountCntrl.value,
                                  width: Get.width / 2.3,
                                  hintText: 'Type Here...',
                                  isBorder: true,

                                  isFilled: false),
                            ],
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EditProfileWidget.commomText('Rent Type',isMandatory: true),
                              bigDropDown(width: 160.5.w, selectedItem: manageCntrl.selectedRentType.value, items: manageCntrl.rentTypeList, onChange: (value){})
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 5.h,),

         Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EditProfileWidget.commomText('Form (Rent)'),
                              ManagementWidgets().datePickerContainer(manageCntrl.rentFrom.value==null?'Select':'${manageCntrl.rentFrom.value!.day}-${manageCntrl.rentFrom.value!.month}-${manageCntrl.rentFrom.value!.year}',
                                  width: 158.w,
                                  onTap: (){
                                    manageCntrl.selectDateFrom(Get.context!);
                                  }
                              ),
                            ],
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EditProfileWidget.commomText('To (Rent)'),
                              ManagementWidgets().datePickerContainer(manageCntrl.rentTo.value==null?'Select':'${manageCntrl.rentTo.value!.day}-${manageCntrl.rentTo.value!.month}-${manageCntrl.rentTo.value!.year}',
                                  width: 158.w,
                                  onTap: (){
                                    manageCntrl.selectDateTo(Get.context!);
                                  }
                              ),
                            ],
                          )
                        ],
                      ),


                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Remarks'),
                      customTextField(
                          controller: manageCntrl.remarkCntrl.value,
                          focusNode: manageCntrl.remarkFocus.value,
                          hintText: 'Type Here...',
                          isBorder: true,
                          color: HexColor('#FFFFFF'),
                          isFilled: false),
                      SizedBox(height: 5.h,),
                      PersonlInfoWidget.commomText('Amenities', icon: InkWell(
                          onTap: (){
                            ManagementWidgets().priceEditingPopup();
                          },
                          child: pencilIcon)),
                      Divider(color:HexColor('#EBEBEB'),height: 1.h,),
                      ManagementWidgets().amenitiesList(),
                      SizedBox(height: 8.h,),
                      customButton(onPressed: (){
                        manageCntrl.onSubmitTap();
                      },text: 'Submit',height: 45.h, width: Get.width)

                    ],
                  );
                }
            ),
          )


        ],
      ),
    ));
  }
}
