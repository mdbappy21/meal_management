import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_management/Data/models/pending_request_model.dart';
import 'package:meal_management/Presentation/state_holder/approve_request_controller.dart';
import 'package:meal_management/Presentation/state_holder/reject_request_controller.dart';

class PendingRequest extends StatefulWidget {
  const PendingRequest({super.key, required this.pendingRequest});

  final PendingRequestModel pendingRequest;

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
                itemCount: widget.pendingRequest.pendingRequests!.length,
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
                                Text(
                                  widget.pendingRequest.pendingRequests![index] ??
                                      'No name',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleSmall,
                                ),
                                // Text(
                                //   'Email: ${widget.pendingRequest[index].userEmail ?? 'N/A'}',
                                //   style: TextStyle(
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                                // Text(
                                //   'Phone: ${widget.pendingRequest[index].userPhone ?? 'N/A'}',
                                //   style: TextStyle(
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                                // Text(
                                //   'Requested At: ${widget.pendingRequest[index].requestedAt ?? 'N/A'}',
                                //   style: TextStyle(
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),Text(
                                //   'Requested ID: ${widget.pendingRequest[index].requestId ?? 'N/A'}',
                                //   style: TextStyle(
                                //     overflow: TextOverflow.ellipsis,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _onTapApproveRequest(
                                      widget.pendingRequest.pendingRequests![index],
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
                                    widget.pendingRequest.pendingRequests![index],
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

  Future<void> _onTapApproveRequest(String email) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool isSuccess = await Get.find<ApproveRequestController>().approveRequest(token!, email);
    if (isSuccess) {
      Get.snackbar("Success", "Member approved!");
    } else {
      Get.snackbar("Failed", "Error: ${Get.find<ApproveRequestController>().errorMassage}");
    }
  }

  Future<void> _onTapRejectRequest(String email) async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken();
    bool isRejected = await Get.find<RejectRequestController>().rejectRequest(token!, email);

    if (isRejected) {
      Get.snackbar("Success", "Join request rejected.");
    } else {
      Get.snackbar("Failed", Get.find<RejectRequestController>().errorMessage ?? "Something went wrong");
    }

  }
}
