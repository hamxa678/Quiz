import 'package:flutter/material.dart';
import 'package:flutter_mvvm_template/UI/screens/home/home_screen_viewmodel.dart';
import 'package:flutter_mvvm_template/core/constants/strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: ChangeNotifierProvider(
        create: (context) => HomeScreenViewModel(),
        child: Consumer<HomeScreenViewModel>(
            builder: (context, model, child) => Builder(builder: (context) {
                  final TabController tabController =
                      DefaultTabController.of(context);
                  tabController.addListener(() {
                    if (!tabController.indexIsChanging) {
                      model.updateIndex(tabController.index);
                    }
                  });
                  return Scaffold(
                    floatingActionButton: _floatingActionButton(model, context),
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
                        child: Column(
                          children: [
                            Padding(
                                padding:
                                    EdgeInsets.fromLTRB(25.w, 65.h, 25.w, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _appBar(),
                                    45.verticalSpace,
                                    Text(
                                      'Hi Hamza Khan',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 35.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    4.verticalSpace,
                                    Text(
                                      'Welcome to Quizz',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                    35.verticalSpace,
                                    _tapBar(model),
                                    25.verticalSpace,
                                  ],
                                )),
                            _tabBarView()
                          ],
                        ),
                      ),
                    ),
                  );
                })),
      ),
    );
  }

  Widget _tabBarView() {
    return Expanded(
      child: TabBarView(children: [
        ListView.builder(
            padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _customCard();
            }),
        ListView.builder(
            padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _customCard();
            }),
      ]),
    );
  }

  Container _customCard() {
    return Container(
      height: 128.h,
      width: 325.w,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xff6F6CE0),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Mobile App Development',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Colors.white,
                  )),
              const Spacer(),
              InkWell(
                  onTap: () {
                    // do something
                  },
                  child:
                      Icon(Icons.more_vert, color: Colors.white, size: 20.sp)),
            ],
          ),
          Text('Wajeeha, Lajeela Sayed, Nimra, Shahirah Ejaz ...',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.sp,
                color: Colors.white,
              )),
          const Spacer(),
          Row(
            children: [
              SizedBox(
                width: 65.w,
                child: Stack(
                  children: [
                    Image.asset('${staticImage}ava1.png',
                        height: 25.h, width: 25.w, fit: BoxFit.scaleDown),
                    Positioned(
                      left: 18.w,
                      child: Image.asset('${staticImage}ava2.png',
                          height: 25.h, width: 25.w, fit: BoxFit.scaleDown),
                    ),
                    Positioned(
                      left: (18 * 2).w,
                      child: Image.asset('${staticImage}ava3.png',
                          height: 25.h, width: 25.w, fit: BoxFit.scaleDown),
                    ),
                  ],
                ),
              ),
              Text('+ 5 more',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    color: Colors.white,
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget _floatingActionButton(
      HomeScreenViewModel model, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // do something
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 24.w),
          decoration: BoxDecoration(
            color: const Color(0xffD9D9D9),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Text(
            // 'Create',
            (model.currentIndex == 0) ? 'Join' : 'Create',
            // 'Create',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              color: const Color(0xff4530B2),
            ),
          )),
    );
  }

  Widget _tapBar(HomeScreenViewModel model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      height: 84.h,
      width: 325.w,
      decoration: BoxDecoration(
        color: const Color(0xff6F6CE0),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: TabBar(
        onTap: ((int index) => model.updateIndex(index)),
        // controller: model.tabController,
        labelColor: const Color(0xff4530B2),
        labelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 20.sp,
        ),
        unselectedLabelColor: Colors.white,
        indicator: BoxDecoration(
          color: const Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(6.r),
        ),
        // indicatorColor: const Color(0xff6F6CE0),
        // indicatorPadding: EdgeInsets.only(right: 75.w),
        tabs: const <Widget>[
          Text("Student"),
          Text("Teacher"),
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
        Image.asset(
          '${staticImage}ava1.png',
          height: 45.h,
          width: 45.w,
          fit: BoxFit.scaleDown,
        ),
      ],
    );
  }
}