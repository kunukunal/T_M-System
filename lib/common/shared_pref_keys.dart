enum SharedPreferencesKeysEnum {
  accessToken("access_token"),
  refreshToken("refresh_token"),
  ispersonalinfocompleted("is_personal_info_completed"),
  islandlord("is_landlord"),
  fcmToken("fcmToken"),

  languaecode("languae_code");

  const SharedPreferencesKeysEnum(this.value);
  final String value;
}
