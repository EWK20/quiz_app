import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/widgets/question_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.restart});

  final List<String> chosenAnswers;
  final void Function() restart;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].question,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final totalQuestions = questions.length;
    final numcorrectQuestions = summaryData.where(
      (element) {
        return element['correct_answer'] == element['user_answer'];
      },
    ).length;

    return SizedBox(
        width: double.infinity,
        child: Container(
            margin: const EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You answered $numcorrectQuestions out of $totalQuestions questions correctly!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: const Color.fromARGB(202, 255, 255, 255),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 30,
                ),
                QuestionSummary(summaryData),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                    onPressed: restart,
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    icon: const Icon(
                      Icons.arrow_right,
                    ),
                    label: Text(
                      'Restart Quiz',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ))
              ],
            )));
  }
}
