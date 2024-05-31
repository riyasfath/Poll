// view_votes_page.dart

import 'package:flutter/material.dart';
import 'package:whatsapp_poll/models/poll_item_model.dart';

class ViewVotesPage extends StatelessWidget {
  final PollItem pollItem;

  const ViewVotesPage(this.pollItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        centerTitle: true,
        leading: const Icon(Icons.menu, color: Color(0xFFE4A951)),
        title: Text(
          'POLLING APP - ${pollItem.options[0]}', // Dynamic title based on first option
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Result',
                style: TextStyle(
                  color: Color(0xFFE4A951),
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
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.white38, width: 0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                optionTitle,
                style: const TextStyle(
                  color: Color(0xFFE4A951),
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
                color: Color(0xFFE4A951),
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }

}
