import 'package:Quizz/UI/custom_widget/custom_button.dart';
import 'package:Quizz/UI/custom_widget/custom_textfield.dart';
import 'package:Quizz/UI/screens/create_quiz/create_quiz_screen.dart';
import 'package:Quizz/UI/screens/create_quiz/create_quiz_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:Quizz/core/constants/strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizFirstScreen extends StatelessWidget {
  const QuizFirstScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
                      36.verticalSpace,
                      Text('Create a new Quiz',
                          style: TextStyle(
                              color: const Color(0xffFFFFFF),
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              fontSize: 29.sp)),
                      8.verticalSpace,
                      Text('Dear Instructor create a new Quiz.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: const Color(0xffFFFFFF),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              fontSize: 20.sp)),
                      36.verticalSpace,
                      CustomTextField(
                        validator: (value) =>
                            value!.isEmpty ? 'Enter title' : null,
                        controller: model.titleController,
                        hintText: 'Add title',
                      ),
                      20.verticalSpace,
                      CustomTextField(
                        validator: (value) =>
                            value!.isEmpty ? 'Enter description' : null,
                        controller: model.descriptionController,
                        hintText: 'Add description',
                      ),
                      36.verticalSpace,
                      CustomButton(
                        onPressed: () {
                          if (model.formKey.currentState!.validate()) {
                            Get.to(CreateQuizScreen(
                                title: model.titleController.text,
                                description: model.descriptionController.text));
                          }
                        },
                        titleWidget: Text('Next',
                            style: TextStyle(
                                color: const Color(0xff4530B2),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 22.sp)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _appBar() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          '${staticIcon}logo1.svg',
          fit: BoxFit.scaleDown,
        ),
      ],
    );
  }
}
