import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/poll_item_model.dart';
import '../services/create_poll_popup.dart';
import '../views/viewVotesPage.dart';

class HomeController extends GetxController {
  Rx<PollItem?> currentPoll = Rx<PollItem?>(null);
  Rx<String?> selectedOption = Rx<String?>(null); // Added selectedOption variable

  @override
  void onInit() {
    super.onInit();
    loadPoll();
  }

  void showCreatePollPopup() {
    Get.dialog(CreatePollPopup(
      onPollCreated: (pollItem) {
        currentPoll.value = pollItem;
        savePoll(pollItem);
      },
    ));
  }

  void voteForOption(String option) {
    selectedOption.value = option; // Update selectedOption when an option is voted
    if (currentPoll.value != null) {
      currentPoll.value!.voteForOption(option);
      savePoll(currentPoll.value!);
    }
  }

  void viewVotes() {
    if (currentPoll.value != null) {
      Get.to(ViewVotesPage(currentPoll.value!));
    } else {
      Get.snackbar('Error', 'No poll available');
    }
  }

  Future<void> savePoll(PollItem pollItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('poll', pollItem.toString());
  }

  Future<void> loadPoll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? pollString = prefs.getString('poll');
    if (pollString != null) {
      currentPoll.value = PollItem.fromString(pollString);
    }
  }
}
