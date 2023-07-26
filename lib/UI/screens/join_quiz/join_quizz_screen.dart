import 'package:Quizz/UI/custom_widget/custom_button.dart';
import 'package:Quizz/UI/custom_widget/custom_textfield.dart';
import 'package:Quizz/UI/screens/join_quiz/join_quizz_screen_viewmodel.dart';
import 'package:Quizz/UI/screens/join_quiz/joined_quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:Quizz/core/constants/strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinQuizScreen extends StatelessWidget {
  JoinQuizScreen({Key? key, required this.userName}) : super(key: key);
  final String userName;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider(
        //     create: (context) => JoinQuizScreenViewModel(),
        //     child:
        Consumer<JoinQuizScreenViewModel>(
      builder: (_, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
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
                  Text('Join Quiz',
                      style: TextStyle(
                          color: const Color(0xffFFFFFF),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          fontSize: 29.sp)),
                  8.verticalSpace,
                  Text('Dear $userName please add code to join Quiz.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: const Color(0xffFFFFFF),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 20.sp)),
                  36.verticalSpace,
                  CustomTextField(
                    validator: (value) =>
                        value!.isEmpty ? 'Enter QC code' : null,
                    controller: model.qcController,
                    hintText: 'Add QC code',
                  ),
                  36.verticalSpace,
                  CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await model.getQuizQuestion();
                        Get.to(const JoinedQuizScreen());

                        // Get.to(() => const JoinedQuizScreen());
                        // Get.to(CreateQuizScreen(
                        //     title: model.titleController.text,
                        //     description: model.descriptionController.text)
                        //     );
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
      // )
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
      ],
    );
  }
}
