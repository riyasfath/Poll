import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/poll_item_model.dart';

class CreatePollPopup extends StatefulWidget {
  final Function(PollItem) onPollCreated;

  CreatePollPopup({required this.onPollCreated});

  @override
  _CreatePollPopupState createState() => _CreatePollPopupState();

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CreatePollPopup(onPollCreated: onPollCreated),
    );
  }
}

class _CreatePollPopupState extends State<CreatePollPopup> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _questionController,
              style: const TextStyle(color: Colors.blueGrey ), // Color(0xFFE4A951)),
              decoration: InputDecoration(
                hintText: 'Question.....',
                hintStyle: TextStyle(color: Colors.blueGrey .withOpacity(0.5)),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow),
                ),
              ),
            ),
            const SizedBox(height: 10),
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
                    widget.onPollCreated(pollItem);
                    Get.back(); // Close the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:   Colors.blueGrey,//Color(0xFFE4A951),
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
              style: const TextStyle(color: Colors.blueGrey), // Color(0xFFE4A951)),
              decoration: InputDecoration(
                hintText: 'Option $optionNumber',
                hintStyle: TextStyle(color: Colors.blueGrey.withOpacity(0.5)),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.blueGrey ), //Color(0xFFE4A951)),
            onPressed: () {
              setState(() {
                controller.clear();
              });
            },
          ),
        ],
      ),
    );
  }
}
