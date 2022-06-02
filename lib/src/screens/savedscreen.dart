import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:international_recipes/src/bloc/app_bloc.dart';
import 'package:international_recipes/src/constants/colors.dart';
import 'package:international_recipes/src/constants/consts_variables.dart';
import 'package:international_recipes/src/constants/strings.dart';
import 'package:international_recipes/src/database/hive.dart';
import 'package:international_recipes/src/models/recipe_model.dart';
import 'package:international_recipes/src/widgets/recipe_card.dart';
import 'package:sizer/sizer.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.yellow,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                  onTap: () {
                    HiveHelper.deleteallrecipes();
                    setState(() {});
                  },
                  child: const Icon(Icons.delete)),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<AppBloc, AppState>(
            builder: (context, state) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 3.h),
                child: savedrecipes.isEmpty
                    ? const Center(
                        child: Text("No Saved Recipes"),
                      )
                    : StaggeredGrid.count(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        children: List<Widget>.generate(
                            savedrecipes.length,
                            (index) => StaggeredGridTile.count(
                                  crossAxisCellCount: 2,
                                  mainAxisCellCount: index.isEven ? 3 : 2,
                                  child: _buildcard(context, index),
                                )),
                      )),
          ),
        ),
      ),
    );
  }

  Widget _buildcard(context, index) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, detailedscreen,
            arguments: savedrecipes[index]);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: CachedNetworkImageProvider(
                  savedrecipes[index].img,
                ),
                fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 24.w,
              padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.2.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade500.withOpacity(0.7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.timelapse,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text(
                    savedrecipes[index].min.toString() + '  min',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 9.sp, color: Colors.white),
                  )
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 17.w,
                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.2.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.yellow),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 17.sp,
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      savedrecipes[index].rate.toString(),
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 9.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
