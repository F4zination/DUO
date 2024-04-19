import 'package:duo_client/utils/constants.dart';
import 'package:duo_client/widgets/duo_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddTile extends StatefulWidget {
  const AddTile({
    super.key,
    required this.Dialog,
  });

  final Widget Dialog;

  @override
  State<AddTile> createState() => _AddTileState();
}

class _AddTileState extends State<AddTile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return DuoContainer(
      width: 120,
      height: 80,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(Constants.defaultRadius),
          onTap: () {
            setState(() {
              isLoading = true;
            });
            showDialog(
              context: context,
              builder: (context) => widget.Dialog,
            ).then((value) {
              setState(() {
                isLoading = false;
              });
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(Constants.defaultPadding),
            child: isLoading
                ? const SpinKitFadingFour(
                    color: Colors.white,
                    size: 30,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 40,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Add',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
