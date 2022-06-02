import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:international_recipes/src/bloc/app_bloc.dart';
import 'package:international_recipes/src/constants/assets_path.dart';
import 'package:international_recipes/src/constants/colors.dart';
import 'package:international_recipes/src/constants/consts_variables.dart';
import 'package:international_recipes/src/constants/strings.dart';
import 'package:international_recipes/src/models/recipe_model.dart';
import 'package:international_recipes/src/widgets/mytextfield.dart';
import 'package:international_recipes/src/widgets/recipe_card.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late TextEditingController _searchcontroller;
  bool isSearching = false;
  List<Recipe> searchedlist = [];

  @override
  void initState() {
    super.initState();

    _controller = TabController(length: 5, vsync: this);
    _searchcontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _searchcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      MyAssets.baker,
                      height: 8.h,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, savedscreen);
                      },
                      child: Material(
                        elevation: 6,
                        borderRadius: BorderRadius.circular(13),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(13)),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.bookmark_added_outlined,
                            color: MyColors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  'Make your own food,',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text.rich(
                    TextSpan(text: 'stay ', children: [
                      TextSpan(
                        text: 'at home.',
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: MyColors.yellow),
                      )
                    ]),
                    style: Theme.of(context).textTheme.headline1),
                SizedBox(
                  height: 4.h,
                ),
                MyTextField(
                  controller: _searchcontroller,
                  func: () {
                    setState(() {
                      isfiltered = !isfiltered;
                    });
                    if (_controller.index != 0) {
                      _controller.animateTo(0);
                    }

                    if (isfiltered) {
                      allrecipes.sort(((a, b) => b.rate.compareTo(a.rate)));
                    } else {
                      allrecipes.shuffle();
                    }
                  },
                  onchange: (value) {
                    if (_controller.index != 0) {
                      _controller.animateTo(0);
                    }
                    setState(() {
                      isSearching = true;
                      searchedlist = allrecipes
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                      if (_searchcontroller.text.isEmpty) {
                        isSearching = false;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 4.h,
                ),
                TabBar(
                    controller: _controller,
                    isScrollable: true,
                    physics: const BouncingScrollPhysics(),
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 8.sp),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 9.sp, color: MyColors.yellow),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    unselectedLabelColor: Colors.grey.shade800,
                    padding: EdgeInsets.zero,
                    labelColor: Colors.amber,
                    tabs: mytabs),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  height: 39.h,
                  child: BlocBuilder<AppBloc, AppState>(
                    builder: (context, state) {
                      if (state is LoadingState || state is AppInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is LoadedState || allrecipes.isNotEmpty) {
                        return TabBarView(controller: _controller, children: [
                          _buildgridview(
                              isSearching ? searchedlist : allrecipes),
                          _buildgridview(americanecipes),
                          _buildgridview(moroccanrecipes),
                          _buildgridview(koreanrecipes),
                          _buildgridview(frenchrecipes),
                        ]);
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  GridView _buildgridview(List<Recipe> list) {
    return GridView.builder(
        itemCount: list.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 30),
        itemBuilder: (context, index) {
          return RecipeCard(recipe: list[index]);
        });
  }
}
