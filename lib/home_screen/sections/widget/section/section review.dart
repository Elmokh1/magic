import 'package:magic_bakery/database/model/secttions_model.dart';

import '../../../../all_import.dart';

class SectionReview extends StatelessWidget {
  SectionsModel sections;

  SectionReview({required this.sections});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("الكل"),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("${sections.name}"),
        )
      ],
    );
  }
}
