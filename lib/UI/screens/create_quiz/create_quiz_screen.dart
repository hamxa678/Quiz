import 'package:Quizz/UI/custom_widget/custom_button.dart';
import 'package:Quizz/UI/custom_widget/custom_textfield.dart';
import 'package:Quizz/UI/screens/create_quiz/create_quiz_screen_viewmodel.dart';
import 'package:Quizz/core/enums/view_state.dart';
import 'package:flutter/material.dart';
import 'package:Quizz/core/constants/strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateQuizScreen extends StatelessWidget {
  final String title;
  final String description;
  const CreateQuizScreen(
      {Key? key, required this.title, required this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: ChangeNotifierProvider(
          create: (context) => CreateQuizScreenViewModel(),
          child: Consumer<CreateQuizScreenViewModel>(
            builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Form(
                  key: model.formKey,
                  child: Container(
                    height: 1.sh,
                    width: 1.sw,
                    padding: EdgeInsets.fromLTRB(25.w, 65.h, 25.w, 0),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('${staticImage}Background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _appBar(),
                        59.verticalSpace,
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 20.h),
                            shrinkWrap: true,
                            itemCount: model.quizQuestionList.length + 1,
                            itemBuilder: (context, index) {
                              if (index < model.quizQuestionList.length) {
                                return _question(index + 1, model);
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    model.incrementQuestion();
                                  },
                                  child: Text('+ Add question',
                                      style: TextStyle(
                                          color: const Color(0xffFFFFFF),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins',
                                          fontSize: 20.sp)),
                                );
                              }
                            },
                          ),
                        ),
                        20.verticalSpace,
                        CustomButton(
                          titleWidget: model.state == ViewState.busy
                              ? const CircularProgressIndicator(
                                  color: Color(0xff4530B2),
                                )
                              : Text(
                                  'Create Quiz',
                                  style: TextStyle(
                                      color: const Color(0xff4530B2),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      fontSize: 20.sp),
                                ),
                          onPressed: () {
                            if (model.formKey.currentState!.validate()) {
                              model.createQuiz(title, description);
                            }
                          },
                        ),
                        25.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget _question(int questionNumber, CreateQuizScreenViewModel model) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (DismissDirection direction) {
        model.deleteQuestion(questionNumber - 1);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question $questionNumber:',
            style: TextStyle(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                fontSize: 20.sp),
          ),
          14.verticalSpace,
          CustomTextField(
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter question';
              } else {
                return null;
              }
            },
            controller: TextEditingController(
                text: model.quizQuestionList[questionNumber - 1].question),
            onChange: (String question) {
              model.quizQuestionList[questionNumber - 1].question = question;
            },
            hintText: 'Enter your question here',
          ),
          18.verticalSpace,
          Text(
            'Options:',
            style: TextStyle(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                fontSize: 15.sp),
          ),
          10.verticalSpace,
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                model.quizQuestionList[questionNumber - 1].options!.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  model.deleteOption(questionNumber - 1, index);
                },
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: CustomTextField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter option';
                        } else {
                          return null;
                        }
                      },
                      onChange: (String option) {
                        model.quizQuestionList[questionNumber - 1]
                            .options![index].option = option;
                      },
                      controller: TextEditingController(
                          text: model.quizQuestionList[questionNumber - 1]
                              .options![index].option),
                      hintText: 'Option ${index + 1}',
                      suffixIcon: Radio(
                        fillColor: MaterialStateProperty.all(
                          const Color(0xffFFFFFF),
                        ),
                        activeColor: Colors.white,
                        value: index + 1,
                        groupValue: model
                            .quizQuestionList[questionNumber - 1].correctOption,
                        onChanged: (value) {
                          model.toggleCorrectOption(questionNumber - 1, index);
                        },
                      )),
                ),
              );
            },
          ),
          10.verticalSpace,
          Row(
            children: [
              Text(
                'Correct option: ${model.quizQuestionList[questionNumber - 1].correctOption}',
                style: TextStyle(
                    color: const Color(0xffFFFFFF),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    fontSize: 13.sp),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  model.incrementOption(questionNumber - 1);
                },
                child: Text(
                  '+ Add option',
                  style: TextStyle(
                      color: const Color(0xffFFFFFF),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                      fontSize: 15.sp),
                ),
              ),
            ],
          ),
          10.verticalSpace,
          const Divider(color: Colors.white, thickness: 1),
          25.verticalSpace,
        ],
      ),
    );
  }

  Widget _appBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          '${staticIcon}logo1.svg',
          fit: BoxFit.scaleDown,
        ),
        51.horizontalSpace,
        Text('Create Quiz',
            style: TextStyle(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 22.sp)),
      ],
    );
  }
}
