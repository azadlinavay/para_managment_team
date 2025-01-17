import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:para_managment_team/src/salar/firebase_datamanaging.dart';
import 'package:para_managment_team/src/salar/job_model.dart';
import 'package:uuid/uuid.dart';

class AddJob extends StatefulWidget {
  const AddJob({Key? key}) : super(key: key);

  @override
  _AddJobState createState() => _AddJobState();
}

class _AddJobState extends State<AddJob> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final companyNameController = TextEditingController();
  final jobDescriptionController = TextEditingController();
  final numberOfHiresController = TextEditingController();
  final salaryEstimationController = TextEditingController();
  final validateTilController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Add a new job",
            style: TextStyle(fontSize: 20),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                var uid = Uuid();
                FirebaseJob.addJob(Job(
                  uid: uid.toString(),
                  title: titleController.value.text,
                  category: categoryController.value.text,
                  companyName: companyNameController.value.text,
                  jobDescription: jobDescriptionController.value.text,
                  email: emailController.value.text,
                  numberOfHires: int.parse(numberOfHiresController.value.text),
                  salaryEstimation:
                      double.parse(salaryEstimationController.value.text),
                  validateTil: Timestamp.fromDate(
                      DateTime.parse(validateTilController.value.text)),
                  createdAt: Timestamp.fromDate(DateTime.now()),
                  likedUID: [],
                  numberOfViews: 0,
                ));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //title *
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Job Title',
                  ),
                ),
              ),
              //Cactegory *
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: categoryController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Category',
                  ),
                ),
              ),
              //Company name *
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: companyNameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Company name',
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: jobDescriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'job description',
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: numberOfHiresController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'how many hires',
                  ),
                ),
              ),
              //job desc
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: salaryEstimationController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'salary estimation',
                  ),
                ),
              ),
              //job desc
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050))
                        .then((value) {
                      setState(() {
                        validateTilController..text = value.toString();
                        validateTilController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: validateTilController.text.length,
                                affinity: TextAffinity.upstream));
                      });
                    });
                  },
                  readOnly: true,
                  controller: validateTilController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'valid till date',
                  ),
                ),
              ),

              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'send CV to email',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
