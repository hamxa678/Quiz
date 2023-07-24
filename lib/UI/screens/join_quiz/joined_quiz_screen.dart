import 'package:Quizz/UI/custom_widget/custom_button.dart';
import 'package:Quizz/UI/custom_widget/custom_textfield.dart';
import 'package:Quizz/UI/screens/create_quiz/create_quiz_screen_viewmodel.dart';
import 'package:Quizz/UI/screens/join_quiz/join_quizz_screen_viewmodel.dart';
import 'package:Quizz/core/enums/view_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Quizz/core/constants/strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinedQuizScreen extends StatelessWidget {
  const JoinedQuizScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: ChangeNotifierProvider(
          create: (context) => JoinQuizScreenViewModel(),
          child: Consumer<JoinQuizScreenViewModel>(
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
                        _appBar(model),
                        59.verticalSpace,
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 20.h),
                            shrinkWrap: true,
                            itemCount: 3,
                            itemBuilder: (context, index) =>
                                _question(index + 1, model),
                            // {
                            //   if (index < model.quizQuestionList.length) {
                            //     return _question(index + 1, model);
                            //   } else {
                            //     return GestureDetector(
                            //       onTap: () {
                            //         model.incrementQuestion();
                            //       },
                            //       child: Text('+ Add question',
                            //           style: TextStyle(
                            //               color: const Color(0xffFFFFFF),
                            //               fontWeight: FontWeight.w500,
                            //               fontFamily: 'Poppins',
                            //               fontSize: 20.sp)),
                            //     );
                            //   }
                            // },
                          ),
                        ),
                        20.verticalSpace,
                        CustomButton(
                          titleWidget: model.state == ViewState.busy
                              ? const CircularProgressIndicator(
                                  color: Color(0xff4530B2),
                                )
                              : Text(
                                  'Done',
                                  style: TextStyle(
                                      color: const Color(0xff4530B2),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                      fontSize: 20.sp),
                                ),
                          onPressed: () {
                            if (model.formKey.currentState!.validate()) {
                              // model.createQuiz(title, description);
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

  Widget _question(int questionNumber, JoinQuizScreenViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Question $questionNumber:',
            style: TextStyle(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 24.sp)),
        4.verticalSpace,
        Text('Dear Intern please add code to join Quiz.',
            style: TextStyle(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                fontSize: 20.sp)),
        20.verticalSpace,
        Text('Options:',
            style: TextStyle(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 24.sp)),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: 20.h),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => Container(
                margin: EdgeInsets.only(top: 20.h),
                padding: EdgeInsets.fromLTRB(18.w, 17.h, 0, 17.h),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffD9D9D9),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text('Add Option',
                    style: TextStyle(
                        color: const Color(0xffFFFFFF),
                        fontFamily: 'Poppins',
                        fontSize: 15.sp))))
      ],
    );
  }

  Widget _appBar(JoinQuizScreenViewModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          '${staticIcon}logo1.svg',
          fit: BoxFit.scaleDown,
        ),
        51.horizontalSpace,
        Text(model.quizResponse!.title!,
            style: TextStyle(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 22.sp)),
      ],
    );
  }
}
