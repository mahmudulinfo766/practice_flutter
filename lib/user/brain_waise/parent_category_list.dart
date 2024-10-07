import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ParentCategoryList extends StatefulWidget {
  final int? index;

  const ParentCategoryList({super.key, this.index});

  @override
  State<ParentCategoryList> createState() => _ParentCategoryListState();
}

class _ParentCategoryListState extends State<ParentCategoryList> {
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      controller.animateTo(widget.index! * 160,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: SingleChildScrollView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
           10,
                (index) => cheap(
             /* bodyColor: state.selectCategory?.id ==
                  state.parentCategory![index].id
                  ? AppColors.kPrimaryColor
                  : AppColors.kWhiteColor,
              borderColor: state.selectCategory?.id ==
                  state.parentCategory![index].id
                  ? AppColors.kPrimaryColor
                  : AppColors.kButtonBorderColor2,
              textColor: state.selectCategory?.id ==
                  state.parentCategory![index].id
                  ? AppColors.kBodyColor
                  : AppColors.kTextColor,*/
              onTap: () {
                /// change
              /*  context
                    .read<CategoryCubit>()
                    .selectCategory(state.parentCategory![index]);
                context.read<CategoryCubit>().getCategory(
                    parent: state.parentCategory![index].id,
                    categoryType: CategoryType.sub);*/
              },
              title: "eudsud",
            ),
          ),
        ),
      ),
    );
  }

  cheap(
      {title,
        VoidCallback? onTap,
        Color? borderColor,
        Color? bodyColor,
        Color? textColor}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 8),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.amber,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Text(
            "$title",

          ),
        ),
      ),
    );
  }
}
