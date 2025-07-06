class Urls{
  static const String _baseUrl='http://192.168.0.198:8000/';
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
  static const String addMeal='${_baseUrl}meal/add_custom';
  static String addCost(double amount)=>'${_baseUrl}cost/add?amount=$amount';
  static String addDeposit({required String email, required double amount}) => '${_baseUrl}deposit/add?email=$email&amount=$amount';
  static String addMember(String email) => '${_baseUrl}mess/add_member?email=$email';
  static String removeMember({required String email}) => '${_baseUrl}mess/remove_member?email=$email';
  static const String startNewMonth='${_baseUrl}month/start_new';
  static const String previousMonth='${_baseUrl}month/previous';
  static String dueClearPreviousMonth({required String email, required double amount})=>'${_baseUrl}deposit/previous_month?email=$email&amount=$amount';



  static const String updateUtilityBill='${_baseUrl}update-bills';
  static const String endMonth='${_baseUrl}end-month';
}