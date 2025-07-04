class Urls{
  static const String _baseUrl='http://192.168.0.180:8000/';
  static const String userInfo='${_baseUrl}me';
  static String createMess='${_baseUrl}mess/create';
  static const String messInfo='${_baseUrl}mess/info';
  static String joinRequest({required String messName}) => '${_baseUrl}mess/join_request?mess_name=$messName';
  static const String pendingJoinRequests = '${_baseUrl}mess/pending_requests';
  static String approveRequest({required String email}) => '${_baseUrl}mess/approve_request?email=$email';
  static String rejectRequest({required String email}) => '${_baseUrl}mess/reject_request?email=$email';
  static const String leaveMess = '${_baseUrl}mess/leave';
  static const String messMemberDetails='${_baseUrl}month/members_details';
  static const String deleteMess='${_baseUrl}mess/delete';
  static String changeManager(String email)=>'${_baseUrl}mess/change_manager?email=$email';
  static String removeMember({required int memberId}) => '${_baseUrl}remove-member?member_id=$memberId';
  // static const String addMember = '${_baseUrl}add-member-by-email';
  static String addMember(String email) => '${_baseUrl}add-member-by-email?email=$email';
  // static String addMeal({required int memberId, required double qty, required String mealDate}) => '${_baseUrl}add-meal?member_id=$memberId&qty=$qty&meal_date=$mealDate';
  static const String addMeal='${_baseUrl}add-meals';
  static String addDeposit({required int memberId, required double amount}) => '${_baseUrl}add-deposit?member_id=$memberId&amt=$amount';
  // static const String addDeposit='${_baseUrl}add-deposit';
  static const String addCost='${_baseUrl}add-cost';
  static const String updateUtilityBill='${_baseUrl}update-bills';
  static const String endMonth='${_baseUrl}end-month';
}