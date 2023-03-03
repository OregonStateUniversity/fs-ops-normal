import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ops_normal/utils/ops_normal_style.dart';
import 'package:ops_normal/utils/units_converter.dart';

enum LocationUnits { dd, dms }

class DmsDdToggle extends StatefulWidget {
  const DmsDdToggle(
      {super.key,
      required this.longitude,
      required this.latitude,
      required this.altitude});
  final String longitude;
  final String latitude;
  final String altitude;

  @override
  State<DmsDdToggle> createState() => _DmsDdToggleState();
}

class _DmsDdToggleState extends State<DmsDdToggle> {
  LocationUnits _defaultUnit = LocationUnits.dms;
  @override
  void initState() {
    super.initState();
    // _defaultUnit1 = dms();
  }

  List<bool> _selected = [true, false];

  @override
  Widget build(BuildContext context) {
    if (widget.longitude == '-' || widget.latitude == '-') {}
    return Column(
      children: [
        ToggleButtons(
            direction: Axis.horizontal,
            color: Colors.grey.shade700,
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            selectedColor: Colors.green.shade800,
            borderRadius: BorderRadius.circular(10),
            splashColor: Colors.green.shade200,
            onPressed: (index) => setState(() {
                  _selected = [false, false];
                  _selected[index] = true;
                  if (index == 1) {
                    _defaultUnit = LocationUnits.dd;
                  } else {
                    _defaultUnit = LocationUnits.dms;
                  }
                }),
            isSelected: _selected,
            children: const [
              SizedBox(
                  width: 80,
                  child: Text(
                    "DMS",
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                width: 80,
                child: Text(
                  "DD",
                  textAlign: TextAlign.center,
                ),
              ),
            ]),
        const SizedBox(
          height: 8,
        ),
        buildDdDms(),
        Row(
          children: [
            buildCard(
                title: 'Altitude', data: widget.altitude, icon: altitudeIcon),
          ],
        )
      ],
    );
  }

  Widget buildDdDms() {
    if (_defaultUnit == LocationUnits.dd) {
      return dd();
    }
    return dms();
  }

  Widget dms() {
    var long = widget.longitude;
    var lat = widget.altitude;
    if (long != '-' && lat != '-') {
      lat = convertToMS(double.parse(lat));
      long = convertToMS(double.parse(long));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildCard(
          title: "Longitude",
          data: long,
          icon: longitudeIcon,
        ),
        buildCard(
          title: "Latitude",
          data: lat,
          icon: latitudeIcon,
        )
      ],
    );
  }

  Widget dd() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildCard(
            title: "Longitude",
            data: widget.longitude,
            icon: longitudeIcon,
            color: const Color.fromARGB(215, 234, 186, 104)),
        buildCard(
            title: "Latitude",
            data: widget.latitude,
            icon: latitudeIcon,
            color: const Color.fromARGB(215, 234, 186, 104))
      ],
    );
  }
}

Widget buildCard(
    {final title, final data, final icon, final color = Colors.white}) {
  return Expanded(
    child: Card(
      color: color,
      shadowColor: const Color.fromARGB(255, 12, 79, 15),
      child: Column(
        children: [
          icon,
          Text("$title"),
          Text(
            data,
            style: kLocationCardTitleStyle,
          )
        ],
      ),
    ),
  );
}

final Widget latitudeIcon = SvgPicture.string(
    ''' <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-world-latitude" width="24" height="24" viewBox="0 0 24 24" stroke-width="1" stroke="#3c7d4b" fill="none" stroke-linecap="round" stroke-linejoin="round">
   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
   <circle cx="12" cy="12" r="9"></circle>
   <line x1="4.6" y1="7" x2="19.4" y2="7"></line>
   <line x1="3" y1="12" x2="21" y2="12"></line>
   <line x1="4.6" y1="17" x2="19.4" y2="17"></line>
</svg>''');

final Widget longitudeIcon = SvgPicture.string(
    '''<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-world-longitude" width="24" height="24" viewBox="0 0 24 24" stroke-width="1" stroke="#3c7d4b" fill="none" stroke-linecap="round" stroke-linejoin="round">
   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
   <circle cx="12" cy="12" r="9"></circle>
   <path d="M11.5 3a11.2 11.2 0 0 0 0 18"></path>
   <path d="M12.5 3a11.2 11.2 0 0 1 0 18"></path>
   <line x1="12" y1="3" x2="12" y2="21"></line>
</svg>''');

final Widget speedIcon = SvgPicture.string(
    ''' <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-gauge" width="24" height="24" viewBox="0 0 24 24" stroke-width="1" stroke="#3c7d4b" fill="none" stroke-linecap="round" stroke-linejoin="round">
   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
   <circle cx="12" cy="12" r="9"></circle>
   <circle cx="12" cy="12" r="1"></circle>
   <line x1="13.41" y1="10.59" x2="16" y2="8"></line>
   <path d="M7 12a5 5 0 0 1 5 -5"></path>
</svg>''');

final Widget altitudeIcon = SvgPicture.string(
    '''<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-mountain" width="24" height="24" viewBox="0 0 24 24" stroke-width="1" stroke="#3c7d4b" fill="none" stroke-linecap="round" stroke-linejoin="round">
   <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
   <path d="M3 20h18l-6.921 -14.612a2.3 2.3 0 0 0 -4.158 0l-6.921 14.612z"></path>
   <path d="M7.5 11l2 2.5l2.5 -2.5l2 3l2.5 -2"></path>
</svg>''');
