class Urls{
  static const String _baseUrl='http://192.168.0.197:8000/';
  static const String userInfo='${_baseUrl}me';
  static String addMember(String email) => '${_baseUrl}mess/add_member?email=$email';
  static String removeMember({required String email}) => '${_baseUrl}mess/remove_member?email=$email';


  static const String createMess = '${_baseUrl}mess/create';
  static const String messInfo='${_baseUrl}mess/info';
  static const String joinRequest='${_baseUrl}mess/join';
  static const String cancelJoinRequest='${_baseUrl}mess/cancel_request';
  static const String pendingJoinRequests='${_baseUrl}mess/pending_requests';
  static String approveRequest({required int requestId})=>'${_baseUrl}mess/approve/$requestId';
  static String rejectRequest({required int requestId})=>'${_baseUrl}mess/approve/$requestId';
  static const String monthDetails='${_baseUrl}month/details';
  static const String addMeal='${_baseUrl}meal/add';
  static const String mealDetails='${_baseUrl}meal/view_all';
  static const String updateMeals='${_baseUrl}meal/update';
  static const String addCost='${_baseUrl}cost/add';
  static const String costDetails='${_baseUrl}cost/details';
  static const String updateCost='${_baseUrl}cost/update';
  static const String addDeposit='${_baseUrl}deposit/add';
  static const String startNewMonth='${_baseUrl}month/start_new_month';
  static const String previousMonth='${_baseUrl}month/previous';
  static const String clearDue='${_baseUrl}month/clear_due';
  static String changeManager(String email)=>'${_baseUrl}mess/transfer_manager/$email';
  static const String leaveMess ='${_baseUrl}mess/leave';
  static const String deleteMess ='${_baseUrl}mess/delete';


  static const String updateUtilityBill='${_baseUrl}update-bills';
  static const String endMonth='${_baseUrl}end-month';
}