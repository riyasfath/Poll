import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../models/poll_item_model.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Color(0xFFE4A951)),
        title: const Text(
          'POLLING APP',
          style: TextStyle(color: Color(0xFFE4A951)),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE4A951)),
            ),
            child: const CircleAvatar(
              backgroundColor: Color(0xFF1E1E1E),
              child: Text(
                'R',
                style: TextStyle(
                  color: Color(0xFFE4A951),
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              controller.showCreatePollPopup();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xFFE4A951),
              backgroundColor: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Color(0xFFE4A951)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
            ),
            child: const Text(
              'Create a Poll',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Obx(
                  () => Padding(
                padding: const EdgeInsets.all(20.0),
                child: controller.currentPoll.value == null
                    ? const Center(child: Text('No poll created'))
                    : _buildPollCard(controller.currentPoll.value!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPollCard(PollItem pollItem) {
    return SizedBox(
      height: 150, // Reduced height of the poll card
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: const Color(0xFF1E1E1E),
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pollItem.question,
                  style: const TextStyle(
                    color: Color(0xFFE4A951),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Column(
                  children: pollItem.options.map(
                        (option) {
                      final isSelected = controller.selectedOption.value == option;
                      return GestureDetector(
                        onTap: () {
                          controller.voteForOption(option);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: isSelected ? Color(0xFFE4A951) : Colors.transparent,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected ? Colors.black : Colors.transparent,
                                  border: Border.all(color: Colors.yellow),
                                ),
                                child: isSelected
                                    ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.yellow,
                                )
                                    : null,
                              ),
                              Text(
                                option,
                                style: TextStyle(
                                  color: Colors.white,
                                  decoration: isSelected ? TextDecoration.lineThrough : null,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.viewVotes();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xFF1E1E1E),
                      backgroundColor: const Color(0xFFE4A951),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
                    ),
                    child: const Text(
                      'View Votes',
                      style: TextStyle(fontSize: 15),
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


}
