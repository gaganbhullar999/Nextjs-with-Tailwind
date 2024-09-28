class ApiConstant {
  //http://192.168.29.43/Medilabs_new/
  static String HOST_URL = "https://testnmeds.com/";

  static String BASE_URL = HOST_URL + "admin/mobile/v1/api.php?method=";
  static String CATEGORIES = BASE_URL + "category";
  static String TESTS = BASE_URL + "test";
  static String PACKAGES = BASE_URL + "package";
  static String ALL_TEST = BASE_URL + "alltest";
  static String STATE_LIST = BASE_URL + "state";
  static String CITY_LIST = BASE_URL + "city";
  static String CHECK_OTP_USER = BASE_URL + "checkotp&userid=";
  static String OTP = "&otp=";
  static String SPLASHAPI = BASE_URL + "welcome";
  static String HOMEAPI = BASE_URL + "home";
  static String IMAGE_ADDRESS = HOST_URL + "admin/mobile/v1/";
  static String SIGNIN = BASE_URL + "usersignin&mobile=";
  static String GET_PROFILE = BASE_URL + "getuserdata&userid=";
  static String MEDICAL_FORM = BASE_URL + "getorderformdata";
  static String UPDATE_PROFILE = BASE_URL + "updateuserprofile";
  static String UPDATE_Prescription = BASE_URL + "updateuserprescription";
  static String UPDATE_OREDER_Prescription =
      BASE_URL + "updateorderprescription";
  static String CHECK_COUPON_CODE = BASE_URL + "checkcouponcode";
  static String GET_TEST_BY_CATEGORY = BASE_URL + "categorywisetest&catid=";
  static String BOOK_TEST = BASE_URL + "createorder";
  static String CASHFREE_TOKEN = BASE_URL + "getcashfreetoken";
  static String SET_RATING = BASE_URL + "setrating";
  static String GET_ALL_BOOK_TEST = BASE_URL + "getallorder&userid=";
  static String SKYCALL = "https://skycalls.in/click_to_call/?code=SKY2204";
}
