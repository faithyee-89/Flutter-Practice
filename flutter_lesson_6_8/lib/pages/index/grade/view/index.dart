import 'package:cainiaowo/models/grade.dart';
import 'package:cainiaowo/pages/index/bloc/index_bloc.dart';
import 'package:cainiaowo/pages/index/widget/image_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GradePage extends StatelessWidget {
  const GradePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexBloc, IndexState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            ImageGrid(grades: (state.gradeModule?.components as List<Grade>)),
          ],
        );
      },
    );
  }
}
