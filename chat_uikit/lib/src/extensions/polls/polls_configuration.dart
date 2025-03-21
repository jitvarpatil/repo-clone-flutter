import 'package:flutter/material.dart';
import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';

///[PollsConfiguration] is a data class that has configuration properties
///to customize the functionality and appearance of [PollsExtension]
///
/// ```dart
/// PollsConfiguration pollsConfiguration = PollsConfiguration(
///    createPollsStyle: CreatePollsStyle(
///        backgroundColor: Colors.white,
///        questionTextStyle: TextStyle(fontSize: 16),
///        addAnswerTextStyle: TextStyle(color: Colors.blue),
///        answerTextStyle: TextStyle(fontSize: 16),
///        deleteIconColor: Colors.red,
///        addIconColor: Colors.blue,
///        padding: EdgeInsets.all(8.0),
///    ),
///    pollsBubbleStyle: PollsBubbleStyle(),
///    theme: CometChatTheme(),
///    title: "Create a Poll",
///    questionPlaceholderText: "Ask a Question",
///    answerPlaceholderText: "Answer Option",
///    answerHelpText: "Add or Remove Options",
///    addAnswerText: "Add Another Option",
///    deleteIcon: Icon(Icons.delete),
///    closeIcon: Icon(Icons.close),
///    createPollIcon: Icon(Icons.poll),
///    optionTitle: "Option",
///    optionIcon: Icon(Icons.poll),
///    optionStyle: PollsOptionStyle(
///        selectedOptionTextStyle: TextStyle(
///            color: Colors.white,
///            fontWeight: FontWeight.bold,
///        ),
///        unselectedOptionTextStyle: TextStyle(
///            color: Colors.black,
///        ),
///        selectedOptionColor: Colors.blue,
///        unselectedOptionColor: Colors.grey,
///    ),
///);

/// ```
class PollsConfiguration {
  PollsConfiguration({
    this.pollsBubbleStyle,
    this.title,
    this.questionPlaceholderText,
    this.answerPlaceholderText,
    this.answerHelpText,
    this.addAnswerText,
    this.deleteIcon,
    this.closeIcon,
    this.createPollIcon,
    this.optionTitle,
    this.optionIcon,
    this.optionStyle,
  });


  ///[pollsBubbleStyle] styling parameters for polls bubble
  final CometChatPollsBubbleStyle? pollsBubbleStyle;

  ///[title] title default is 'Create Poll'
  final String? title;

  ///[questionPlaceholderText] default is 'Question'
  final String? questionPlaceholderText;

  ///[answerPlaceholderText] default is 'Answer 1'
  final String? answerPlaceholderText;

  ///[answerHelpText] default is 'SET THE ANSWERS'
  final String? answerHelpText;

  ///[addAnswerText] default is 'Add Another Answer'
  final String? addAnswerText;

  ///[deleteIcon]
  final Widget? deleteIcon;

  ///[closeIcon] replace close icon
  final Widget? closeIcon;

  ///[createPollIcon] replace poll icon
  final Widget? createPollIcon;

  ///[optionTitle] is the name for the option for this extension
  final String? optionTitle;

  ///[optionIcon] is the icon for the option for this extension
  final Widget? optionIcon;

  ///[optionStyle] provides style to the option that generates a polls
  final PollsOptionStyle? optionStyle;
}
