import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:international_recipes/src/bloc/app_bloc.dart';
import 'package:international_recipes/src/constants/colors.dart';
import 'package:international_recipes/src/constants/strings.dart';
import 'package:international_recipes/src/database/hive.dart';
import 'package:international_recipes/src/models/recipe_model.dart';
import 'package:international_recipes/src/widgets/mybutton.dart';
import 'package:sizer/sizer.dart';

class DetailedScreen extends StatefulWidget {
  final Recipe recipe;
  const DetailedScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, webscreen,
                arguments: widget.recipe.originalwebsite);
          },
          child: const Icon(Icons.computer),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(widget.recipe.img),
                  fit: BoxFit.fill,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyButton(
                      func: () {
                        Navigator.pop(context);
                      },
                      icon: Icons.chevron_left,
                      color: MyColors.yellow,
                      iccolor: Colors.white,
                    ),
                    const Spacer(),
                    MyButton(
                        iccolor: Colors.white,
                        func: () {
                          setState(() {
                            if (!widget.recipe.saved) {
                              widget.recipe.saved = true;
                              HiveHelper.saverecipe(widget.recipe);
                              BlocProvider.of<AppBloc>(context)
                                  .add(ModifyDataBaseEvent());
                            } else {
                              widget.recipe.saved = false;
                              HiveHelper.deleterecipe(widget.recipe);
                              BlocProvider.of<AppBloc>(context)
                                  .add(ModifyDataBaseEvent());
                            }
                          });
                        },
                        icon: Icons.bookmark_border,
                        color: (widget.recipe.saved)
                            ? Colors.blue
                            : MyColors.yellow),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60.h,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 20.w,
                            height: 5,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(children: [
                          SizedBox(
                            width: 60.w,
                            child: Text(
                              widget.recipe.name,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.w, vertical: 2.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.yellow),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.black,
                                  size: 22.sp,
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  widget.recipe.rate.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                          fontSize: 14.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                          ),
                        ]),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _infowidget(context,
                                data: widget.recipe.min.toString(),
                                icon: Icons.timelapse,
                                title: 'mins'),
                            _infowidget(context,
                                data: 03.toString(),
                                icon: Icons.people,
                                title: 'servs'),
                            _infowidget(context,
                                data: widget.recipe.cal.toString(),
                                icon: Icons.fireplace_outlined,
                                title: 'cal'),
                            _infowidget(context,
                                data: widget.recipe.difficulty.substring(0, 4),
                                icon: Icons.stacked_bar_chart,
                                title: 'state'),
                          ],
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Ingredients",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.recipe.ingredients.length,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          itemBuilder: (context, index) {
                            return _buildingredient(
                              widget.recipe.ingredients[index].quantity,
                              widget.recipe.ingredients[index].name,
                            );
                          },
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Text(
                          "Directions",
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.recipe.steps.length,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                          ),
                          itemBuilder: (context, index) {
                            return _builddirections(widget.recipe.steps[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _builddirections(String direction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 1.h),
            height: 10,
            width: 10,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: MyColors.yellow),
          ),
          SizedBox(
            width: 3.w,
          ),
          Expanded(
            child: Text(
              direction,
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildingredient(String quantity, String name) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 1.h),
          height: 10,
          width: 10,
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: MyColors.yellow),
        ),
        SizedBox(
          width: 3.w,
        ),
        Text(
          quantity,
          style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.w800),
        ),
        SizedBox(
          width: 1.w,
        ),
        Expanded(
          child: Text(
            name,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 10.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w800),
          ),
        ),
      ],
    );
  }

  Container _infowidget(BuildContext context,
      {required IconData icon, required dynamic data, required String title}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      width: 16.w,
      height: 16.h,
      decoration: const BoxDecoration(
          color: MyColors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: Icon(icon),
          ),
          SizedBox(height: 1.3.h),
          Text(
            data,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 10.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.3.h),
          Text(
            title,
            style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 10.sp,
                color: Colors.black,
                fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}
