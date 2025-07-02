class Urls{
  static const String _baseUrl='http://192.168.0.180:8000/';
  static const String userInfo='${_baseUrl}me';
  static const String createMess='${_baseUrl}create-mess';
  static const String messInfo='${_baseUrl}mess-info';
  // static String joinMess({required String messName})=>'${_baseUrl}join-mess?mess_name=$messName';
  static String joinRequest({required String messName}) => '${_baseUrl}join-mess-request?mess_name=$messName';
  static const String pendingJoinRequests = '${_baseUrl}pending-requests';
  // static const String pendingRequest='${_baseUrl}pending-request';
  static String approveRequest({required int requestId}) => '${_baseUrl}approve-request?request_id=$requestId';
  // static const String approveRequest='${_baseUrl}approve-request';
  static String rejectRequest({required int requestId}) => '${_baseUrl}reject-request?request_id=$requestId';
  // static const String rejectRequest='${_baseUrl}reject-request';
  static const String members='${_baseUrl}members';
  static String removeMember({required int memberId}) => '${_baseUrl}remove-member?member_id=$memberId';
  static const String leaveMess = '${_baseUrl}leave-mess';
  // static const String addMember = '${_baseUrl}add-member-by-email';
  static String addMember(String email) => '${_baseUrl}add-member-by-email?email=$email';
  // static String addMeal({required int memberId, required double qty, required String mealDate}) => '${_baseUrl}add-meal?member_id=$memberId&qty=$qty&meal_date=$mealDate';
  static const String addMeal='${_baseUrl}add-meals';
  static const String addDeposit='${_baseUrl}add-deposit';
  static const String addCost='${_baseUrl}add-cost';
  static const String updateUtilityBill='${_baseUrl}update-bills';
  static const String endMonth='${_baseUrl}end-month';
}