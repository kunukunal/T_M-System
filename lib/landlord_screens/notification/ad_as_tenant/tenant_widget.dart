import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tanent_management/common/constants.dart';
import 'package:tanent_management/common/text_styles.dart';
import 'package:tanent_management/common/widgets.dart';
import 'package:tanent_management/landlord_screens/notification/ad_as_tenant/tenant_controller.dart';
import 'package:tanent_management/services/dio_client_service.dart';
import 'package:url_launcher/url_launcher.dart';

class TenantListDetailsScreenWidgets {
  tenantDetailContainer() {
    final cntrl = Get.find<AdasTenatDetailsScreenController>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
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
                        border: Border.all(),
                        shape: BoxShape.circle,
                        image: cntrl.profileImage.value == ""
                            ? DecorationImage(
                                image: profileIconWithWidget.image)
                            : DecorationImage(
                                image: NetworkImage(cntrl.profileImage.value))),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                    child: Text(
                  cntrl.name.value,
                  style: CustomStyles.otpStyle050505W700S16
                      .copyWith(fontWeight: FontWeight.w500),
                )),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                    onTap: () async {
                      if (cntrl.email.isNotEmpty) {
                        try {
                          final nativeUrl = Uri.parse("mailto:${cntrl.email}");
                          if (await canLaunchUrl(nativeUrl)) {
                            await launchUrl(nativeUrl);
                          } else {}
                        } catch (e) {
                          print("sdajkasdj $e");
                        }
                      } else {
                        customSnackBar(Get.context!, "email_not_found".tr);
                      }
                    },
                    child: emailIcon),
                SizedBox(
                  width: 20.w,
                ),
                GestureDetector(
                    onTap: () async {
                      if (cntrl.phoneNumber.isNotEmpty) {
                        try {
                          final nativeUrl =
                              Uri.parse("tel:${cntrl.phoneNumber}");
                          if (await canLaunchUrl(nativeUrl)) {
                            await launchUrl(nativeUrl);
                          } else {}
                        } catch (e) {
                   
                        }
                      } else {
                        customSnackBar(
                            Get.context!, "phone_number_not_found".tr);
                      }
                    },
                    child: callIcon)
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Divider(
              color: HexColor('#EBEBEB'),
              height: .5,
            ),
            SizedBox(
              height: 10.h,
            ),
            detailInnerWidget('${'phone_number'.tr}     :',
                '${cntrl.phoneCode} ${cntrl.phoneNumber}'),
            SizedBox(
              height: 10.h,
            ),
            detailInnerWidget('${'email_address'.tr}      :', '${cntrl.email}'),
            SizedBox(
              height: 10.h,
            ),
            detailInnerWidget(
                '${'address'.tr}                :', '${cntrl.address}'),
            SizedBox(
              height: 10.h,
            ),
            detailInnerWidget(
                '${'occupied_units'.tr}   :', '${cntrl.occupiedUnit}'),
          ],
        ),
      ),
    );
  }

  tenantUnitContainer() {
    final cntrl = Get.find<AdasTenatDetailsScreenController>();

    return cntrl.tenantUnitList.isEmpty
        ? Center(
            child: Text("no_units_found".tr),
          )
        : ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                // height: 208.h,
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
                                  image: cntrl.tenantUnitList[index]['image']
                                          .isEmpty
                                      ? DecorationImage(
                                          image: apartment1Image.image)
                                      : DecorationImage(
                                          image: NetworkImage(
                                              cntrl.tenantUnitList[index]
                                                  ['image'][0]['image_url']))),
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
                                      cntrl.tenantUnitList[index]['name'] ?? "",
                                      style: CustomStyles.black14,
                                    )),
                                    Text(
                                      "₹${cntrl.tenantUnitList[index]['unit_rent']}"
                                          .toString(),
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
                                      cntrl.tenantUnitList[index]['address'] ??
                                          "",
                                      style: CustomStyles.address050505w400s12,
                                    ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Divider(
                        color: HexColor('#EBEBEB'),
                        height: 1,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'amenities'.tr,
                            style: CustomStyles.otpStyle050505.copyWith(
                                fontSize: 14.sp - commonFontSize,
                                fontFamily: 'DM Sans'),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          cntrl.tenantUnitList[index]['amenities'].isEmpty
                              ? Center(
                                  child: Text("no_amenties".tr),
                                )
                              : GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: cntrl
                                      .tenantUnitList[index]['amenities']
                                      .length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 23.h,
                                          mainAxisSpacing: 10.h,
                                          crossAxisSpacing: 5.w),
                                  itemBuilder: (BuildContext context, int ind) {
                                    return SizedBox(
                                      height: 24.h,
                                      width: 156.5.w,
                                      child: Row(
                                        children: [
                                          tickIcon,
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            cntrl.tenantUnitList[index]
                                                ['amenities'][ind]['name'],
                                            style: CustomStyles.black14
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w400),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
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
            itemCount: cntrl.tenantUnitList.length);
  }

  detailInnerWidget(key, value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150.w,
          child: Text(
            key,
            style: CustomStyles.otpStyle050505W400S14,
          ),
        ),
        SizedBox(
          width: 10.h,
        ),
        Expanded(
            child: Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: CustomStyles.desc606060.copyWith(
              fontSize: 14.sp - commonFontSize, fontFamily: 'DM Sans'),
        )),
      ],
    );
  }

  documentList() {
    final docCntrl = Get.find<AdasTenatDetailsScreenController>();
    return Obx(() {
      return docCntrl.kiryederDocumentLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : docCntrl.tenantDoc.isEmpty
              ? Center(
                  child: Text("no_document_found".tr),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10.h,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: docCntrl.tenantDoc.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return documentContainer(
                      image: docCntrl.tenantDoc[index]['image'] ?? "",
                      name: docCntrl.tenantDoc[index]['document_type_value'],
                    );
                  });
    });
  }

  //Document container
  documentContainer({
    required String image,
    required String name,
  }) {
    return Stack(
      children: [
        Container(
          height: 158.h,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: HexColor('#EBEBEB'), width: 1.r),
            // image:  DecorationImage(image: image.image)
          ),
          child: image == ""
              ? SizedBox(
                  width: double.infinity,
                  child: Center(child: Text("no_document_uploaded".tr)))
              : Image.network(
                  image,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
        ),
        Positioned(
          left: .5,
          right: .5,
          bottom: .5,
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: HexColor('#D9E3F4'),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: CustomStyles.skipBlack.copyWith(
                      fontSize: 16.sp - commonFontSize,
                      fontWeight: FontWeight.w400,
                    ),
                  )),
                  if (image != "")
                    GestureDetector(
                        onTap: () {
                          _saveNetworkImage(image);
                        },
                        child: downloadIcon)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _saveNetworkImage(String url) async {
    try {
      await DioClientServices.instance.saveImageToGallery(url).then((value) {
        if (value['isSuccess'] == true) {
          customSnackBar(Get.context!, "document_download_successfully".tr);
        }
      });
    } on Error {
      throw 'Error has occured while saving';
    }
  }
}
