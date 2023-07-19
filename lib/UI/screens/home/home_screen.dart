import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Quizz/UI/screens/home/home_screen_viewmodel.dart';
import 'package:Quizz/core/constants/strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../create_quiz/create_quiz_first_sreen.dart';

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
                  return WillPopScope(
                    onWillPop: () async {
                      final status = await Get.dialog(AlertDialog(
                        title: const Text('Caution!'),
                        content: const Text(
                            'Do you really want to close the application?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Get.back(result: true);
                            },
                            child: const Text('Yes'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back(result: false);
                            },
                            child: const Text('No'),
                          ),
                        ],
                      ));

                      return status;
                    },
                    child: Scaffold(
                      floatingActionButton:
                          _floatingActionButton(model, context),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _appBar(model),
                                      45.verticalSpace,
                                      Text(
                                        'Hi ${model.firebaseService.userProfile.name}',
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
                              _tabBarView(model)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })),
      ),
    );
  }

  Widget _tabBarView(HomeScreenViewModel model) {
    return Expanded(
      child: TabBarView(children: [
        ListView.builder(
            padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _customCard('Mobile App Development',
                  'Wajeeha, Lajeela Sayed', model, '', 'Hamza Khan');
            }),
        StreamBuilder<QuerySnapshot>(
          stream: model.teacherQuizzesStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                  padding: EdgeInsets.fromLTRB(25.w, 0, 25.w, 0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return _customCard(
                      snapshot.data!.docs[index]['title'].toString(),
                      snapshot.data!.docs[index]['description'].toString(),
                      model,
                      snapshot.data!.docs[index]['quizUID'].toString(),
                      snapshot.data!.docs[index]['authorName'].toString(),
                    );
                  });
            }
          },
        ),
      ]),
    );
  }

  Container _customCard(String title, String description,
      HomeScreenViewModel model, String quizUID, String autherName) {
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
              Text(title,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Colors.white,
                  )),
              const Spacer(),
              InkWell(
                  onTap: () {
                    model.deleteQuiz(quizUID);
                  },
                  child:
                      Icon(Icons.more_vert, color: Colors.white, size: 20.sp)),
            ],
          ),
          Row(
            children: [
              Text('"$description"',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    color: Colors.white,
                  )),
              // autherName
              Text(" created by $autherName",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    fontSize: 11.sp,
                    color: Colors.white,
                  )),
            ],
          ),
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
        (model.currentIndex == 1) ? Get.to(const QuizFirstScreen()) : null;
        // Get.to(const CreateQuizScreen()) : null;
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

  Widget _appBar(HomeScreenViewModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            model.firebaseAuthService.logOut();
          },
          child: SvgPicture.asset(
            '${staticIcon}logo1.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        const Spacer(),
        (model.firebaseService.userProfile.profileImageUrl == null ||
                model.firebaseService.userProfile.profileImageUrl! == '')
            ? Container(
                height: 45.h,
                width: 45.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.w),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/avatar.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                height: 45.h,
                width: 45.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.w),
                  image: DecorationImage(
                    image: NetworkImage(
                        model.firebaseService.userProfile.profileImageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
      ],
    );
  }
}
