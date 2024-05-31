import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/poll_item_model.dart';

class CreatePollPopup extends StatefulWidget {
  final Function(PollItem) onPollCreated;

  CreatePollPopup({required this.onPollCreated});

  @override
  _CreatePollPopupState createState() => _CreatePollPopupState();
}

class _CreatePollPopupState extends State<CreatePollPopup> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  int _optionCount = 3;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: AlertDialog(
        backgroundColor: Colors.black87,
        content: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 0),
                TextField(
                  controller: _questionController,
                  style: const TextStyle(color: Color(0xFFE4A951)),
                  decoration: InputDecoration(
                    hintText: 'Question.....',
                    hintStyle: TextStyle(color: Color(0xFFE4A951).withOpacity(0.5)),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                _buildOptionTextField(_option1Controller, 1),
                _buildOptionTextField(_option2Controller, 2),
                _buildOptionTextField(_option3Controller, 3),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        var question = _questionController.text;
                        var options = [
                          _option1Controller.text.trim(),
                          _option2Controller.text.trim(),
                          _option3Controller.text.trim(),
                        ];
                        var pollItem = PollItem(question: question, options: options, votes: {});
                        Get.find<HomeController>().currentPoll.value = pollItem;
                        widget.onPollCreated(pollItem); // Notify the callback about the new poll
                        Get.back(); // Close the dialog
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFE4A951),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Create',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTextField(TextEditingController controller, int optionNumber) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Color(0xFFE4A951)),
              decoration: InputDecoration(
                hintText: 'Option $optionNumber',
                hintStyle: TextStyle(color: const Color(0xFFE4A951).withOpacity(0.5)),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Color(0xFFE4A951)),
            onPressed: () {
              setState(() {
                controller.clear();
                _updateOptionCount();
              });
            },
          ),
        ],
      ),
    );
  }

  void _updateOptionCount() {
    int count = 0;
    if (_option1Controller.text.isNotEmpty) count++;
    if (_option2Controller.text.isNotEmpty) count++;
    if (_option3Controller.text.isNotEmpty) count++;
    _optionCount = count;
  }
}
