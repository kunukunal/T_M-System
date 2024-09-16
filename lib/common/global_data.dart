List state = [
  "Select",
  "Andaman and Nicobar Islands",
  "Andhra Pradesh",
  "Arunachal Pradesh",
  "Assam",
  "Bihar",
  "Chandigarh",
  "Chhattisgarh",
  "Dadra and Nagar Haveli and Daman and Diu",
  "Delhi",
  "Goa",
  "Gujarat",
  "Haryana",
  "Himachal Pradesh",
  "Jammu and Kashmir",
  "Jharkhand",
  "Karnataka",
  "Kerala",
  "Ladakh",
  "Lakshadweep",
  "Madhya Pradesh",
  "Maharashtra",
  "Manipur",
  "Meghalaya",
  "Mizoram",
  "Nagaland",
  "Odisha",
  "Puducherry",
  "Punjab",
  "Rajasthan",
  "Sikkim",
  "Tamil Nadu",
  "Telangana",
  "Tripura",
  "Uttar Pradesh",
  "Uttarakhand",
  "West Bengal"
];
Map userData = {
  "id": 0,
  "name": "",
  "phone_code": "",
  "phone": "",
  "email": "",
  "profile_image": "",
  "user_type": 0,
  "user_type_value": "",
  "user_documents": false,
  "email_verified": false
};

bool isLandlord = false;
clearAll() {
  isLandlord = false;
  userData = {
    "id": 0,
    "name": "",
    "phone_code": "",
    "phone": "",
    "email": "",
    "profile_image": "",
    "user_type": 0,
    "user_type_value": "",
    "user_documents": false,
    "email_verified": false
  };
}
