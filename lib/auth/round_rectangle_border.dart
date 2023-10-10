import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({super.key , required this.title , required this.onTap , this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue.shade800,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(child: loading ? Container(height: 20 , width: 20 , child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white,)) : Text(title , style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),))
      ),
    );
  }
}
