import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:tanent_management/common/global_data.dart';
import 'package:tanent_management/common/shared_pref_keys.dart';
import 'package:tanent_management/services/shared_preferences_services.dart';
import 'package:tanent_management/tenant_screens/explore/unit_details/unit_detail_view.dart';

class AppLinkUri {
  final appLinks = AppLinks();
  init() {
    String recieveValue = "";
    appLinks.uriLinkStream.listen((uri) async {
      if (uri.queryParameters.isEmpty)
        return;
      else {
        print("dsakldksa ${uri.queryParameters}");
        Map<String, String> param = uri.queryParameters;
        recieveValue = param['code'] ?? "";
        if (recieveValue != "") {
          String decrypted = xorDecrypt(recieveValue);
          if (decrypted != "errroOccurRentpur") {
            String token = await SharedPreferencesServices.getStringData(
                    key: SharedPreferencesKeysEnum.accessToken.value) ??
                "";
            if (token != "") {
              await Future.delayed(
                Duration(seconds: 4),
                () {
                  Get.to(() => UnitDetailView(),
                      arguments: [int.tryParse(decrypted), false]);
                },
              );
            } else {}
          } else {}
        } else {}
      }
    });
  }
}
