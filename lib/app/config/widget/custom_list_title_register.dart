import 'package:flutter/material.dart';
import 'package:tbs_logistics_tms/app/config/data/color.dart';

class CustomListTitleRegisted extends StatelessWidget {
  const CustomListTitleRegisted({
    super.key,
    required this.stt,
    required this.name,
    required this.phone,
    required this.warehome,
    required this.itemstype,
    required this.onTap,
    // required this.cccd,
  });
  final String stt;
  final String name;
  final String phone;
  final String warehome;
  final String itemstype;
  final VoidCallback? onTap;
  // final String cccd;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Card(
          margin: const EdgeInsets.only(bottom: 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: CustomColor.backgroundAppbar)
              //set border radius more than 50% of height and width to make circle
              ),
          shadowColor: Colors.grey,
          elevation: 10,
          child: SizedBox(
            width: size.width,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStt(),
                // VerticalDivider(
                //   indent: 15,
                //   endIndent: 15,
                // ),
                _buildName(context),
                const VerticalDivider(
                  indent: 15,
                  endIndent: 15,
                ),
                _buildWareHome(context),
              ],
            ),
          )),
    );
  }

  Widget _buildStt() {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              // color: Colors.redAccent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                width: 1,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            child: Center(
              child: Text(stt),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
                // Expanded(
                //   child: Text(
                //     cccd,
                //     style: CustomTextStyle.textPrimary,
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(phone),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWareHome(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  itemstype,
                  style: TextStyle(color: Theme.of(context).primaryColorLight),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(warehome),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
