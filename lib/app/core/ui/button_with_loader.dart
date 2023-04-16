import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonWithLoader<B extends StateStreamable<S>, S>
    extends StatelessWidget {
  final BlocWidgetSelector<S, bool> selector;
  final B bloc;
  final VoidCallback onPressed;
  final String label;

  const ButtonWithLoader({
    super.key,
    required this.selector,
    required this.bloc,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: BlocSelector<B, S, bool>(
          bloc: bloc,
          selector: selector,
          builder: (context, showLoading) {
            if (!showLoading) {
              return Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                ),
              );
            }

            return Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
