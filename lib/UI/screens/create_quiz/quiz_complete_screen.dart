import 'package:Quizz/UI/custom_widget/custom_button.dart';
import 'package:Quizz/UI/custom_widget/custom_textfield.dart';
import 'package:Quizz/UI/screens/create_quiz/create_quiz_screen_viewmodel.dart';
import 'package:Quizz/UI/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:Quizz/core/constants/strings.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizCompleteScreen extends StatelessWidget {
  final String quizUID;
  final String authorName;
  const QuizCompleteScreen(
      {Key? key, required this.quizUID, required this.authorName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CreateQuizScreenViewModel(),
        child: Consumer<CreateQuizScreenViewModel>(
          builder: (context, model, child) => WillPopScope(
            onWillPop: () async {
              Get.offAll(const HomeScreen());
              return true;
            },
            child: Scaffold(
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
                        Text('Quiz Complete',
                            style: TextStyle(
                                color: const Color(0xffFFFFFF),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                fontSize: 34.sp)),
                        8.verticalSpace,
                        Text(
                            '$authorName, You have successfully created a quiz. Kindly share the following QC with your students to join.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: const Color(0xffFFFFFF),
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 18.sp)),
                        36.verticalSpace,
                        CustomTextField(
                          readOnly: true,
                          controller: TextEditingController(
                            text: quizUID,
                          ),
                          prefexIcon: SvgPicture.asset(
                            '${staticIcon}QC.svg',
                            height: 14.96.h,
                            width: 26.44.w,
                            fit: BoxFit.scaleDown,
                          ),
                          hintText: 'Quiz code',
                          suffixIcon: GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: quizUID));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Copied to Clipboard'),
                                  ),
                                );
                              },
                              child: const Icon(Icons.copy,
                                  color: Color(0xffFFFFFF))),
                        ),
                        36.verticalSpace,
                        CustomButton(
                          onPressed: () {
                            Get.offAll(const HomeScreen());
                          },
                          titleWidget: Text('Done',
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
