import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/pending_request_model.dart';
import 'package:meal_management/Presentation/state_holder/approve_request_controller.dart';
import 'package:meal_management/Presentation/state_holder/reject_request_controller.dart';

class PendingRequest extends StatefulWidget {
  const PendingRequest({super.key, required this.pendingRequest});

  final List<PendingRequestModel> pendingRequest;

  @override
  State<PendingRequest> createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pending Join request')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ListView.builder(
                itemCount: widget.pendingRequest.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.pendingRequest[index].userEmail, style: Theme.of(context,).textTheme.titleSmall,),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _onTapApproveRequest(
                                      widget.pendingRequest[index].id,
                                  );
                                },
                                icon: Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _onTapRejectRequest(
                                    widget.pendingRequest[index].id,
                                  );
                                },
                                icon: Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapApproveRequest(int requestId) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool isSuccess = await Get.find<ApproveRequestController>().approveRequest(token!, requestId);
    if (isSuccess) {
      Get.snackbar("Success", "Member approved!");
    } else {
      Get.snackbar("Failed", "Error: ${Get.find<ApproveRequestController>().errorMassage}");
    }
  }

  Future<void> _onTapRejectRequest(int requestId) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool isRejected = await Get.find<RejectRequestController>().rejectRequest(token!, requestId);

    if (isRejected) {
      Get.snackbar("Success", "Join request rejected.");
    } else {
      Get.snackbar("Failed", Get.find<RejectRequestController>().errorMessage ?? "Something went wrong");
    }

  }
}
