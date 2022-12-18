
import 'package:flutter/material.dart';
import 'package:shop/conponents/conponents.dart';
import 'package:shop/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_Screen/login_screen.dart';
import 'style/color.dart';
class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body
});
}
class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  bool isLast =false;
  List<BoardingModel>boarding=[
    BoardingModel(
        image: 'https://elearningindustry.com/wp-content/uploads/2021/10/a-successful-remote-onboarding-guide.jpg',
        title: 'on board 1 Title ',
        body: 'on board 1 body '),
    BoardingModel(
        image: 'https://elearningindustry.com/wp-content/uploads/2021/10/a-successful-remote-onboarding-guide.jpg',
        title: 'on board 2 Title ',
        body: 'on board 2 body '),
    BoardingModel(
        image: 'https://elearningindustry.com/wp-content/uploads/2021/10/a-successful-remote-onboarding-guide.jpg',
        title: 'on board 3 Title ',
        body: 'on board 3 body '),

  ];
  PageController pageController=PageController();

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){

      if(value){

        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
//list for hem items the on boarding
    return Scaffold(
      appBar: AppBar(
        actions: [
         defaultTextButton(
             onPressed:submit,
           text:'SKIP',
           fontSize: 20

         )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                  itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                itemCount:boarding.length,
                controller:pageController ,
                onPageChanged: (index){

                  if(index==boarding.length-1)
                   {
                     setState(() {
                       isLast=true;

                     });
                   }
                },
                physics: const BouncingScrollPhysics(),
              ),
            ),
            const SizedBox(
              height:30 ,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmoothPageIndicator(
                    controller:pageController,
                    effect:const ExpandingDotsEffect(
                      activeDotColor:defaultColor,
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor:4,
                      spacing: 4
                    ),
                    count: boarding.length
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed:(){
                    if(isLast)
                    {
                      pageController.nextPage(
                          duration: const Duration(
                            milliseconds: 720,
                          ),
                          curve: Curves.linear,


                      );
                      submit();
                    }
                    else {
                      pageController.nextPage(
                          duration: const Duration(
                            milliseconds: 720,
                          ),
                          curve: Curves.linear);
                    }
                    },
                  child:const Icon(Icons.navigate_next_sharp,size: 40,),

                ),
              ],
            ),

          ],
        ),
      ),
    );
  }


//items onBoarding Screen
  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image.network(model.image)),
      const SizedBox(
        height:30 ,
      ),
      Text(model.title,
          style:const TextStyle(
              fontSize: 40,
            fontWeight: FontWeight.bold
          )),
      const SizedBox(
        height:10 ,
      ),
      Text(model.body,
          style:const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          )
      ),


    ],
  );
}
