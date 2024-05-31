// poll_item_model.dart

import 'dart:convert';

class PollItem {
  late String question;
  late List<String> options;
  late Map<String, int> votes;

  PollItem({
    required this.question,
    required this.options,
    required this.votes,
  });

  // Method to vote for an option
  void voteForOption(String option) {
    if (votes.containsKey(option)) {
      votes[option] = votes[option]! + 1;
    }
  }

  // Method to convert poll item to string
  String toString() {
    return jsonEncode({
      'question': question,
      'options': options,
      'votes': votes,
    });
  }

  // Method to create poll item from string
  factory PollItem.fromString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return PollItem(
      question: json['question'],
      options: List<String>.from(json['options']),
      votes: Map<String, int>.from(json['votes']),
    );
  }
}
