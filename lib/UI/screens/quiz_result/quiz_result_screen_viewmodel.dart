import 'package:Quizz/UI/screens/quiz_result/quiz_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:Quizz/core/constants/strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: ChangeNotifierProvider(
        create: (context) => ResultScreenViewModel(),
        child: Consumer<ResultScreenViewModel>(
          builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                height: 1.sh,
                width: 1.sw,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('${staticImage}Background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(25.w, 65.h, 25.w, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _appBar(),
                        38.verticalSpace,
                        _upperCard(),
                        42.verticalSpace,
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(bottom: 5.h),
                            // shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount: model.result.length,
                            itemBuilder: (context, index) {
                              return _customListTile(
                                  model.result[index].image!,
                                  model.result[index].name!,
                                  model.result[index].scorePercent!,
                                  index);
                            },
                          ),
                        ),
                        // _customListTile()
                      ],
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customListTile(
      String image, String name, int scorePercent, int index) {
    return Container(
      height: 55.h,
      width: 325.w,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: (index == 0)
              ? [
                  const Color(0xff152854),
                  const Color(0xff152854).withOpacity(0.7),
                ]
              : (index == 1)
                  ? [
                      const Color(0xffC81D20),
                      const Color(0xffC81D20).withOpacity(0.7),
                    ]
                  : (index == 2)
                      ? [
                          const Color(0xff5FB3D2),
                          const Color(0xff5FB3D2).withOpacity(0.7),
                        ]
                      : [
                          const Color(0xff6F6CE0),
                          const Color(0xff6F6CE0),
                        ],
        ),
      ),
      child: Row(children: [
        Image.asset(
          image,
          height: 35.h,
          width: 35.w,
          fit: BoxFit.scaleDown,
        ),
        15.horizontalSpace,
        Text(
          name,
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        10.horizontalSpace,
        if (index < 3)
          Image.asset(
            (index == 0)
                ? '${staticImage}gold.png'
                : (index == 1)
                    ? '${staticImage}silver.png'
                    : '${staticImage}bronze.png',
            height: 35.h,
            width: 17.5.w,
            fit: BoxFit.scaleDown,
          ),
        const Spacer(),
        Text(
          'Score: $scorePercent%',
          style: TextStyle(
            fontFamily: 'poppins',
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }

  Widget _upperCard() {
    return SizedBox(
      height: 279.h,
      width: 325.w,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            child: Column(
              children: [
                Image.asset(
                  '${staticImage}ava1.png',
                  height: 110.h,
                  width: 110.w,
                  fit: BoxFit.scaleDown,
                ),
                26.verticalSpace,
                Text(
                  '2nd',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 35.sp,
                    color: Colors.white,
                  ),
                ),
                5.verticalSpace,
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Image.asset(
                  '${staticImage}ava8.png',
                  height: 110.h,
                  width: 110.w,
                  fit: BoxFit.scaleDown,
                ),
                26.verticalSpace,
                Text(
                  '3rd',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontSize: 35.sp,
                    color: Colors.white,
                  ),
                ),
                5.verticalSpace,
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Image.asset(
                  '${staticImage}crown.png',
                  height: 49.h,
                  width: 70.w,
                  fit: BoxFit.scaleDown,
                ),
                20.verticalSpace,
                Image.asset(
                  '${staticImage}1st.png',
                  height: 135.h,
                  width: 135.w,
                  fit: BoxFit.scaleDown,
                ),
                5.verticalSpace,
                Text(
                  '1st',
                  style: TextStyle(
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 45.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
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
        const Spacer(),
      ],
    );
  }
}
