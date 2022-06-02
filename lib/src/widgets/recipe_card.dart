import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:international_recipes/src/constants/colors.dart';
import 'package:international_recipes/src/constants/strings.dart';
import 'package:international_recipes/src/models/recipe_model.dart';
import 'package:sizer/sizer.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, detailedscreen, arguments: recipe);
          },
          child: AspectRatio(
            aspectRatio: 1 / 1.6,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        recipe.img,
                      ),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 1.w, vertical: 0.2.h),
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
                          recipe.min.toString() + '  min',
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.w, vertical: 0.2.h),
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
                            recipe.rate.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
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
          ),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          recipe.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style:
              Theme.of(context).textTheme.headline1!.copyWith(fontSize: 13.sp),
        )
      ],
    );
  }
}
