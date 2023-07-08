import 'package:Quizz/UI/custom_widget/custom_textfield.dart';
import 'package:Quizz/UI/screens/create_quiz/create_quiz_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:Quizz/UI/screens/home/home_screen_viewmodel.dart';
import 'package:Quizz/core/constants/strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateQuizScreen extends StatelessWidget {
  const CreateQuizScreen({Key? key}) : super(key: key);
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
                          itemCount: model.numberOfQuestion + 1,
                          itemBuilder: (context, index) {
                            if (index < model.numberOfQuestion) {
                              return _question();
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  model.incrementNumberOfQuestion();
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
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  Widget _question() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question 1:',
          style: TextStyle(
              color: const Color(0xffFFFFFF),
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
              fontSize: 20.sp),
        ),
        14.verticalSpace,
        CustomTextField(
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
        CustomTextField(
          hintText: 'Option 1',
        ),
        10.verticalSpace,
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '+ Add option',
            style: TextStyle(
                color: const Color(0xffFFFFFF),
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                fontSize: 15.sp),
          ),
        ),
        14.verticalSpace,
      ],
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
