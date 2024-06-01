import 'package:flutter/material.dart';
import 'package:whatsapp_poll/models/poll_item_model.dart';

class ViewVotesPage extends StatelessWidget {
  final PollItem pollItem;

  const ViewVotesPage(this.pollItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change background color to white
      appBar: AppBar(
        backgroundColor: Colors.white, // Change app bar background color to white
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Colors.blueGrey), // Change icon color to blueGrey
        title: const Text(
          'POLLING APP ', // Dynamic title based on first option
          style: TextStyle(color: Colors.blueGrey), // Change title color to blueGrey
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blueGrey), // Change border color to blueGrey
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.white, // Change circle avatar background color to white
              child: Text(
                'R',
                style: TextStyle(
                  color: Colors.blueGrey, // Change text color to blueGrey
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Result',
                style: TextStyle(
                  color: Colors.blueGrey, // Change text color to blueGrey
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildOptionList(pollItem.options[0], pollItem.votes[pollItem.options[0]], context),
            _buildOptionList(pollItem.options[1], pollItem.votes[pollItem.options[1]], context),
            _buildOptionList(pollItem.options[2], pollItem.votes[pollItem.options[2]], context),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionList(String optionTitle, int? votes, BuildContext context) {
    final voteCount = votes ?? 0; // Using null-aware operator to provide a default value of 0 if votes is null
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(18.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white, // Change container background color to white
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.8), // Change shadow color to blueGrey with opacity
            blurRadius: 5,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.blueGrey, width: 0.5), // Change border color to blueGrey
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                optionTitle,
                style: const TextStyle(
                  color: Colors.blueGrey, // Change text color to blueGrey
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            child: Text(
              'Votes: $voteCount', // Using the non-nullable voteCount variable
              style: const TextStyle(
                color: Colors.blueGrey, // Change text color to blueGrey
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
