import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:medilabs/cart/ui/patient_details_screen.dart';
import 'package:medilabs/helper/constant.dart';
import 'package:medilabs/helper/widgets/custom_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get.dart';

class PatientTestDate extends StatefulWidget {
  @override
  State<PatientTestDate> createState() => _PatientTestDateState();
}

class _PatientTestDateState extends State<PatientTestDate> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool dateSelected = false;
  bool showCalender = false;

  bool morningTimeSelected = false;
  bool afternoonTimeSelected = false;
  bool eveningTimeSelected = false;

  String selectedData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Select Test Date"),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                    showCalender = true;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 12),
                  height: 60,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Container(
                      child: Center(
                        child: Text(
                          "Select Date",
                          style: TextStyle(fontWeight: FontWeight.w600,
                          fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              showCalender?buildCalender():Container(),

              dateSelected
                  ? buildSection(MediaQuery.of(context).size.width)
                  : Container()
            ],
          ),



          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.all(24),
                child: CustomButton(
                    label: "Proceed",
                    color: Constant.hexToColor(Constant.primaryBlue),
                    textColor: Colors.white,
                    borderColor: Constant.hexToColor(Constant.primaryBlue),
                    onPressed: () {

                      if(!dateSelected){

                        Constant.showToast("Please select test date");

                      }else if(!morningTimeSelected&&!afternoonTimeSelected&&!eveningTimeSelected){

                        Constant.showToast("Please select test preferred time");

                      }else {

                        Get.to(PatientDetailsScreen());

                      }


                    },
                    fontSize: 16,
                    padding: 8,
                    height: 45,
                    width: 150),
              ))
        ],
      ),
    );
  }

  Widget buildCalender() {
    return Container(
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(Duration(days: 60)),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          // Use `selectedDayPredicate` to determine which day is currently selected.
          // If this returns true, then `day` will be marked as selected.

          // Using `isSameDay` is recommended to disregard
          // the time-part of compared DateTime objects.
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;

               dateSelected = true;

              showCalender = false;
              selectedData = selectedDay.day.toString()+"/"+selectedDay.month.toString()+"/"+selectedDay.year.toString();

            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      ),
    );
  }

  Widget buildSection(double width) {
    return Column(

      children: [
        SizedBox(height: 12,),

        Text("Date "+selectedData!=null?"Date "+selectedData:"NA",style: TextStyle(
          fontSize: 18,fontWeight: FontWeight.w600
        ),),
        SizedBox(height: 12,),

        Container(
          height: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    morningTimeSelected = true;
                    afternoonTimeSelected = false;
                    eveningTimeSelected = false;
                  });
                },
                // onTap: () => Get.to(AllTest(cateogoryTest: false)),
                child: Container(

                  height: 130,
                  width: width * .3,
                  child: Card(
                    color: morningTimeSelected
                        ? Colors.greenAccent.withOpacity(.9)
                        : Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Container(
                              margin: EdgeInsets.all(8),
                              child: Text(
                                "Morning",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Text(
                                "10AM to 1PM",

                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    morningTimeSelected = false;
                    afternoonTimeSelected = true;
                    eveningTimeSelected = false;
                  });
                },
                child: Container(

                  height: 130,
                  width: width * .3,
                  child: Card(
                    color: afternoonTimeSelected
                        ? Colors.greenAccent.withOpacity(.9)
                        : Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.all(8),
                              child: Text(
                                "Afternoon",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Text(
                                "1PM to 4PM",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    morningTimeSelected = false;
                    afternoonTimeSelected = false;
                    eveningTimeSelected = true;
                  });
                },
                child: Container(

                  height: 130,
                  width: width * .3,
                  child: Card(
                    color: eveningTimeSelected
                        ? Colors.greenAccent.withOpacity(.9)
                        : Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Container(
                              margin: EdgeInsets.all(8),
                              child: Text(
                                "Evening",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Text(
                                "4PM to 8PM",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.center,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: AlertDialog(
            title: const Text('AlertDialog Title'),
            content: buildCalender(),
            // actions: <Widget>[
            //   TextButton(
            //     child: const Text('Approve'),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ],
          ),
        );
      },
    );
  }
}
