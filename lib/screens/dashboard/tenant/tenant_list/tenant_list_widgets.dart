import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/screens/dashboard/tenant/tenant_list/tenant_list_controller.dart';

class TenantListWidgets{


  //List container widget
  containerWidget(index){

    final tenantCntrl = Get.find<TenantListController>();
    return Dismissible(
      key: Key(index.toString()),
      onDismissed: (direction)async
      {
        bool value= await tenantCntrl.onTenantDelete();

      },
      background: const Icon(Icons.delete),
      child: InkWell(
        onTap: (){
          tenantCntrl.onTenantTap();
        },
        child: Container(
          height: 84.h,
          width: Get.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: HexColor('#EBEBEB'))
          ),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: HexColor('#444444'),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image:
                          tenantCntrl.tenantList[index]['image']
                              .image,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( tenantCntrl.tenantList[index]['name'],style: CustomStyles.otpStyle050505.copyWith(fontSize: 16.sp),),
                     SizedBox(height: 2.h,),
                      SizedBox(
                        height: 40.h,
                          width: double.infinity,
                          child: Text( tenantCntrl.tenantList[index]['address'],maxLines:2,overflow: TextOverflow.ellipsis,style: CustomStyles.desc606060.copyWith(fontSize: 14.sp),))
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  //**********************************Tenant Widgets*****************************

  tenantDetailContainer(){
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: 200.h,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                ClipRect(
                  child: Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: profileIconWithWidget.image)
                    ),

                  ),
                ),SizedBox(width: 10.w,),
                Expanded(child: Text('Darlene Robertson',style: CustomStyles.otpStyle050505W700S16.copyWith(fontWeight: FontWeight.w500),)),
               SizedBox(width: 10.w,),
                emailIcon,
                SizedBox(width: 20.w,),
                callIcon
              ],
            ),
            SizedBox(height: 5.h,),
            Divider(color: HexColor('#EBEBEB'),height: .5,),
            SizedBox(height: 10.h,),
            detailInnerWidget('Phone Number     :','+91 8123456790'),
            SizedBox(height: 10.h,),
            detailInnerWidget('Email Address      :','robert121@gmail.com'),
            SizedBox(height: 10.h,),
            detailInnerWidget('Address                :','4140 Parker Rd. Allentown, New Mexico 31134'),
            SizedBox(height: 10.h,),
            detailInnerWidget('Occupied units   :','2'),
          ],
        ),
      ),
    );
  }

  tenantRentContainer(){
     double totalRent = 1000.0;  // Total rent amount
     double paidRent = 400.0;    // Amount of rent paid
     double progress = paidRent / totalRent;
    return Container(
      height: 115.h,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: HexColor('#EBEBEB')),
        borderRadius: BorderRadius.circular(10.r)
      ),
      child: Padding(
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rent',style: CustomStyles.otpStyle050505W700S16,),
                Row(
                  children: [
                    Text('Month to Month',style: CustomStyles.desc606060.copyWith(fontSize: 14.sp,fontFamily: 'DM Sans'),),
                  SizedBox(width: 10.w,),
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
                    Text('Rent paid',style: CustomStyles.desc606060.copyWith(fontSize: 14.sp,fontFamily: 'DM Sans'),),
                    Text('₹1500.00',style: CustomStyles.black16,),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Due',style: CustomStyles.desc606060.copyWith(fontSize: 14.sp,fontFamily: 'DM Sans'),),
                    Text('₹1500.00',style: CustomStyles.black16,),
                  ],
                )
              ],
            ),

          ],
        ),
      ),
    );

  }

  tenantUnitContainer(){
    final cntrl = Get.find<TenantListController>();
    List amenities ;
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
        itemBuilder: (context, index){
        amenities = cntrl.tenantUnitList[index]['amenities'];
          return Container(
            // height: 208.h,
            width: double.infinity,
            decoration:  BoxDecoration(
                border: Border.all(color: HexColor('#EBEBEB')),
                borderRadius: BorderRadius.circular(10.r)
            ),
            child: Padding(padding: EdgeInsets.all(10.r),
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
                            image: DecorationImage(image: cntrl.tenantUnitList[index]['image'].image)
                        ),

                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(cntrl.tenantUnitList[index]['name'],style: CustomStyles.black14,)),
                              Text(cntrl.tenantUnitList[index]['rate'],style: CustomStyles.amountFA4343W700S12,)
                            ],
                          ),
                          SizedBox(height: 8.h,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.location_on_outlined,size: 25.r,)
                              ,SizedBox(width: 5.w,),
                              Expanded(child: Text(cntrl.tenantUnitList[index]['address'],

                                style: CustomStyles.address050505w400s12,))
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5.h,),
                Divider(color: HexColor('#EBEBEB'),height: 1,),
                SizedBox(height: 5.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amenities', style: CustomStyles.otpStyle050505.copyWith(fontSize: 14.sp,fontFamily: 'DM Sans'),),
                    SizedBox(height: 5.h,),
                    SizedBox(
                      height: 65 .h,
                      child: GridView.builder(
                        physics:const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: amenities.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 23.h,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 5.w
                          ),
                        itemBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height:24.h,
                            width: 156.5.w,
                            child: Row(
                              children: [
                                tickIcon,
                                SizedBox(width: 5.w,),
                                Text(amenities[index], style: CustomStyles.black14.copyWith(fontWeight: FontWeight.w400),)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

              ],
            ),
            ),
          );
        },
        separatorBuilder: (context, index){
          return SizedBox(height: 10.h,);
        },
        itemCount: cntrl.tenantUnitList.length);

  }

  tenantPaymentHistoryContainer(){
    final cntrl = Get.find<TenantListController>();
    return ListView.separated(
        shrinkWrap: true,
        physics:const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
      return Container(
        height: 95.h,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: HexColor('#EBEBEB')),
            borderRadius: BorderRadius.circular(10.r)
        ),
        child:  Padding(
          padding:  EdgeInsets.all(10.r),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                    color: HexColor('#BCD1F3'),
                    borderRadius: BorderRadius.circular(10.r)
                ),
                child: Center(
                  child: Text(
                    cntrl.paymentList[index]['date'],
                    textAlign: TextAlign.center,
                    style: CustomStyles.black16.copyWith(fontSize: 14.sp,),
                  ),
                ),
              ),
              SizedBox(width: 10.w,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cntrl.paymentList[index]['unitName'],
                      textAlign: TextAlign.center,
                      style: CustomStyles.black16.copyWith(fontSize: 15.sp,),
                    ),
                    SizedBox(height: 5.w,),
                    Text(
                      cntrl.paymentList[index]['description'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CustomStyles.desc606060.copyWith(fontSize: 12.sp,fontFamily: 'DM Sans'),
                    ),
                  ],
                ),
              ),
              Text(
                cntrl.paymentList[index]['amount'],
                style: CustomStyles.amountFA4343W500S15,
              ),
            ],
          ),
        ),

      );
    }, separatorBuilder: (context, index){
      return SizedBox(height: 10.h,);
    }, itemCount: cntrl.paymentList.length);

  }

  detailInnerWidget(key,value){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 150.w,
          child: Text(key,style: CustomStyles.otpStyle050505W400S14,),
        ),
        SizedBox(width: 10.h,),
        Expanded(child: Text(value,maxLines: 2,overflow: TextOverflow.ellipsis, style: CustomStyles.desc606060.copyWith(fontSize: 14.sp,fontFamily: 'DM Sans'),)),
      ],
    );
  }
}