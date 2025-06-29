class Urls{
  static const String _baseUrl='http://192.168.0.180:8000/';
  static const String userInfo='${_baseUrl}me';
  static const String createMess='${_baseUrl}create-mess';
  static const String messInfo='${_baseUrl}mess-info';
  // static String joinMess({required String messName})=>'${_baseUrl}join-mess?mess_name=$messName';
  static String joinRequest({required String messName})=>'${_baseUrl}join-mess-request';
  static const String pendingRequest='${_baseUrl}pending-request';
  static const String approveRequest='${_baseUrl}approve-request';
  static const String rejectRequest='${_baseUrl}reject-request';
  static const String members='${_baseUrl}members';
  static const String removeMember='${_baseUrl}remove-member';
  static const String addMeal='${_baseUrl}add-meal';
  static const String addDeposit='${_baseUrl}add-deposit';
  static const String addCost='${_baseUrl}add-cost';
  static const String updateUtilityBill='${_baseUrl}update-bills';
  static const String endMonth='${_baseUrl}end-month';
}