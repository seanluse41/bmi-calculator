import 'package:bmi_calculator/bmi_calculator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmi_calculator/reuseable_card.dart';
import 'constants.dart';
import 'results_page.dart';
import 'bottom_button.dart';

enum GenderCard {
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  GenderCard selectedGender;
  int selectedHeight = 180;
  int selectedWeight = 60;
  int selectedAge = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, //keeps middle height card expanded
          children: <Widget>[
            Expanded(
                child: Row(
              children: <Widget>[
                Expanded(
                  child: ReussableCard(
                    gesture: () {
                      setState(() {
                        selectedGender = GenderCard.male;
                      });
                    },
                    colour: selectedGender == GenderCard.male
                        ? cardColor
                        : inactiveCardColor,
                    cardChild: IconCardContent(
                      icon: FontAwesomeIcons.mars,
                      copy: 'MALE',
                    ),
                  ),
                ),
                Expanded(
                  child: ReussableCard(
                    gesture: () {
                      setState(() {
                        selectedGender = GenderCard.female;
                      });
                    },
                    colour: selectedGender == GenderCard.female
                        ? cardColor
                        : inactiveCardColor,
                    cardChild: IconCardContent(
                      icon: FontAwesomeIcons.venus,
                      copy: 'FEMALE',
                    ),
                  ),
                ),
              ],
            )),
            Expanded(
              child: ReussableCard(
                colour: cardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'HEIGHT',
                      style: labelTextStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          selectedHeight.toString(),
                          style: numberTextStyle,
                        ),
                        Text(
                          "CM",
                          style: labelTextStyle,
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0),
                        thumbColor: bottomContainerColor,
                        inactiveTrackColor: inactiveCardColor,
                        activeTrackColor: bottomContainerColor,
                      ),
                      child: Slider(
                        value: selectedHeight.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newHeight) {
                          setState(() {
                            selectedHeight = newHeight.round();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ReussableCard(
                      colour: cardColor,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'WEIGHT',
                            style: labelTextStyle,
                          ),
                          Text(
                            selectedWeight.toString(),
                            style: numberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    selectedWeight--;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    selectedWeight++;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ReussableCard(
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'AGE',
                            style: labelTextStyle,
                          ),
                          Text(
                            selectedAge.toString(),
                            style: numberTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundIconButton(
                                icon: FontAwesomeIcons.minus,
                                onPressed: () {
                                  setState(() {
                                    selectedAge--;
                                  });
                                },
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              RoundIconButton(
                                icon: FontAwesomeIcons.plus,
                                onPressed: () {
                                  setState(() {
                                    selectedAge++;
                                  });
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                      colour: cardColor,
                    ),
                  ),
                ],
              ),
            ),
            BottomButton(
              buttonTitle: 'CALCULATE',
              onTap: () {
                BMICalculator calc = BMICalculator(height: selectedHeight, weight: selectedWeight);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ResultsPage(
                      bmiResult: calc.calculateBMI(),
                      resultText: calc.BMIResult(),
                      interpretation: calc.getInterpretation(),
                    )));
              },
            ),
          ],
        ),
      ),
    );
  }
}



class RoundIconButton extends StatelessWidget {
  RoundIconButton({this.icon, this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child: Icon(icon),
      onPressed: onPressed,
      shape: CircleBorder(),
      fillColor: inactiveCardColor,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      elevation: 6.0,
    );
  }
}
