import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../models/poll_item_model.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white ,//Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor:  Colors.white, //Color(0xFF1E1E1E),
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.blueGrey), // Color(0xFFE4A951)),
        title: const Text(
          'POLLING APP',
          style: TextStyle(color: Colors.blueGrey), //(0xFFE4A951)),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blueGrey), // Color(0xFFE4A951)),
            ),
            child: const CircleAvatar(
              backgroundColor:  Colors.white,//Color(0xFF1E1E1E),
              child: Text(
                'R',
                style: TextStyle(
                  color: Colors.blueGrey,//Color(0xFFE4A951),
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              controller.showCreatePollPopup(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor:  Colors.blueGrey,//  Color(0xFFE4A951),
              backgroundColor:  Colors.white, //const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: Colors.blueGrey), //Color(0xFFE4A951)),
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
                child: controller.polls.isEmpty
                    ? const Center(
                    child: Text('No polls created', style: TextStyle(color: Colors.blueGrey)))
                    : ListView.builder(
                  itemCount: controller.polls.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = controller.polls.length - index - 1;
                    return _buildPollCard(controller.polls[reversedIndex], context, reversedIndex);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPollCard(PollItem pollItem, BuildContext context, int pollIndex) {
    return SizedBox(
      child: Card(
        color: Colors.white, // const Color(0xFF1E1E1E),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  pollItem.question,
                  style: const TextStyle(
                    color: Colors.blueGrey ,//Color(0xFFE4A951),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Column(
                children: pollItem.options.map((option) {
                  return Obx(() {
                    final isSelected = controller.selectedOption.value == option;
                    return GestureDetector(
                      onTap: () {
                        controller.voteForOption(option, pollIndex);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: isSelected ? Colors.blueGrey  : Colors.transparent,
                            width: 2,
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
                                border: Border.all(color: Colors.lightBlue),
                              ),
                              child: isSelected
                                  ? const Icon(
                                Icons.check,
                                size: 16,
                                color: Colors.lightBlue,
                              )
                                  : null,
                            ),
                            Text(
                              option,
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    );
                  });
                }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      controller.viewVotes(pollIndex);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor:  Colors.white,// const Color(0xFF1E1E1E),
                      backgroundColor:  Colors.blueGrey,//const Color(0xFFE4A951),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 90),
                    ),
                    child: const Text(
                      'View Votes',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
