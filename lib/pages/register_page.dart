import 'package:flutter/material.dart';
import '../components/custom_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int currentStep = 0;
  bool isRegistrationCompleted = false;

  final firstNameTextEditingController = TextEditingController();
  final middleNameTextEditingController = TextEditingController();
  final lastNameTextEditingController = TextEditingController();
  final dateOfBirthTextEditingController = TextEditingController();
  final genderTextEditingController = TextEditingController();
  String? selectedGender;
  final addressTextEditingController = TextEditingController();
  final contactNumberTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "The Stepper Widget",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF133A70),
      ),
      body: isRegistrationCompleted
          ? displaySuccessfulRegistration()
          : Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: Color(0xFF133A70)),
              ),
              child: Stepper(
                type: StepperType.horizontal,
                steps: getSteps(),
                currentStep: currentStep,
                onStepContinue: () {
                  final isLastStep = currentStep == getSteps().length - 1;

                  if (isLastStep) {
                    setState(() {
                      isRegistrationCompleted = true;
                    });
                    print('Registration Completed!');

                    //Send data to Server
                  } else {
                    setState(() {
                      currentStep += 1;
                    });
                  }
                },
                onStepCancel: () {
                  currentStep == 0
                      ? null
                      : setState(() {
                          currentStep -= 1;
                        });
                },
                onStepTapped: (step) => setState(() {
                  currentStep = step;
                }),
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                      final isLastStep = currentStep == getSteps().length - 1;

                      return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: details.onStepContinue,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF133A70),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: Text(isLastStep ? 'SUBMIT' : 'NEXT'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (currentStep > 0)
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: details.onStepCancel,
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Color(0xFF133A70)),
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                  ),
                                  child: Text('BACK'),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
              ),
            ),
    );
  }

  List<Step> getSteps() => [
    Step(
      title: const Text("Personal Information"),
      state: currentStep > 0 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 0,
      content: Column(
        children: <Widget>[
          CustomTextfield(
            controller: firstNameTextEditingController,
            labelText: "First Name",
            hintText: "Enter your first name",
            prefixIcon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your first name";
              }
              return null;
            },
          ),
          
          const SizedBox(height: 30.0,),

          CustomTextfield(
            controller: middleNameTextEditingController,
            labelText: "Middle Name",
            hintText: "Enter your middle name",
            prefixIcon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your middle name";
              }
              return null;
            },
          ),

          const SizedBox(height: 30.0,),

          CustomTextfield(
            controller: lastNameTextEditingController,
            labelText: "Last Name",
            hintText: "Enter your last name",
            prefixIcon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your last name";
              }
              return null;
            },
          ),

          const SizedBox(height: 30.0,),

          CustomTextfield(
            controller: dateOfBirthTextEditingController,
            labelText: "Date of Birth",
            hintText: "Enter your date of birth",
            prefixIcon: Icons.place,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your address";
              }
              return null;
            },
          ),

          const SizedBox(height: 30.0,),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
            ),
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: DropdownButtonFormField<String>(
              value: selectedGender,
              decoration: InputDecoration(
                labelText: "Gender",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.person, color: Color(0xFF133A70)),
              ),
              items: [
                DropdownMenuItem(value: "Male", child: Text("Male")),
                DropdownMenuItem(value: "Female", child: Text("Female")),
                DropdownMenuItem(value: "Other", child: Text("Other")),
              ],
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                  genderTextEditingController.text = value ?? '';
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select your gender";
                }
                return null;
              },
              style: TextStyle(fontSize: 16.0, color: Colors.black),
              dropdownColor: Colors.white,
              isExpanded: true,
            ),
          ),

          const SizedBox(height: 60.0,),

          CustomTextfield(
            controller: addressTextEditingController,
            labelText: "Address",
            hintText: "Enter your address",
            prefixIcon: Icons.place,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your address";
              }
              return null;
            },
          ),

          const SizedBox(height: 30.0,),

          CustomTextfield(
            controller: contactNumberTextEditingController,
            labelText: "Contact Number",
            hintText: "Enter your contact number",
            prefixIcon: Icons.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your contact number";
              }
              return null;
            },
          ),


        ],
      ),
    ),
    Step(
      title: const Text("Vehicle Information"),
      state: currentStep > 1 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 1,
      content: Column(children: <Widget> [

        ],
      ),
    ),
    Step(
      title: const Text("Biometrics"),
      state: currentStep > 2 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 2,
      content: Column(children: <Widget> [

        ],
      ),
    ),
    Step(
      title: const Text("Complete"),
      state: currentStep > 3 ? StepState.complete : StepState.indexed,
      isActive: currentStep >= 3,
      content: Column(children: <Widget>[

        ],
      ),
    ),
  ];

  displaySuccessfulRegistration() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Registration \n Successful!",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 40.0),

          ElevatedButton(
            onPressed: () {
              setState(() {
                isRegistrationCompleted = false;
                currentStep = 0;
              });

              firstNameTextEditingController.clear();
              lastNameTextEditingController.clear();
              addressTextEditingController.clear();

              //Go to login
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF133A70),
              fixedSize: Size(400.0, 90.0), // Changed height from 200 to 60
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ), // Optional: adds slight rounding
              ),
            ),
            child: const Text(
              "Login now",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
