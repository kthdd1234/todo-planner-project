import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  CommonContainer({
    super.key,
    required this.child,
    this.innerPadding,
    this.outerPadding,
  });

  Widget child;
  double? innerPadding, outerPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding != null
          ? EdgeInsets.fromLTRB(outerPadding!, 0, outerPadding!, outerPadding!)
          : const EdgeInsets.all(0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: null,
        padding: EdgeInsets.all(innerPadding != null ? innerPadding! : 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 206, 206, 206).withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(2, 4),
              )
            ]),
        child: child,
      ),
    );
  }
}
