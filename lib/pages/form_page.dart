import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qualplaca/engine/inference.dart';
import 'package:qualplaca/pages/result_page.dart';
import 'package:qualplaca/widgets/button_widget.dart';

class FormPage extends StatefulWidget {
  const FormPage({
    super.key,
  });

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController budgetController = TextEditingController();
  final TextEditingController vramController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final InferenceEngine inferenceEngine = InferenceEngine();

  bool brandPrefer = false;

  List<String> tags = ['Jogos', 'Trabalho', 'Mineração', 'Tô podendo'];
  List<String> selectedTags = ['Jogos', 'Trabalho', 'Mineração', 'Tô podendo'];
  bool isTagSelected(String tag) {
    return selectedTags.contains(tag);
  }

  void toggleTagSelection(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.add(tag);
      }
    });
  }

  Future<void> getResult() async {
    try {
      var result = inferenceEngine.inference(
        preferBrand: brandPrefer,
        brand: brandController.value.text,
        budget: double.parse(budgetController.value.text),
        vram: int.parse(vramController.value.text),
        tags: selectedTags,
      );

      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => ResultPage(
            gpu: result['gpu'],
            recommended: result['recommendedGPUs'],
          ),
        ),
      );
    } catch (e) {
      log(e.toString());

      if (e.toString().contains("Bad state: No element")) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.black,
            content: Row(
              children: const [
                Text("Nenhuma placa encontrada com essas informações"),
              ],
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.black,
            content: Row(
              children: const [
                Text("Revise os dados informados!"),
              ],
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeData.light().scaffoldBackgroundColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Expanded(
                              child: Text(
                                "Parâmetros",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Preencha todos os campos para continuar ao resultado",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: budgetController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Valor disponível",
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: vramController,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintText: "Máximo de memória",
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Wrap(
                      spacing: 8.0,
                      children: tags.map((tag) {
                        return FilterChip(
                          label: Text(tag),
                          onSelected: (selected) {
                            toggleTagSelection(tag);
                          },
                          selected: isTagSelected(tag),
                          selectedColor: Colors.black,
                          backgroundColor: Colors.grey[300],
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isTagSelected(tag)
                                ? Colors.white
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        const Text("Preferência por marca?"),
                        Switch(
                          value: brandPrefer,
                          activeColor: Colors.black,
                          onChanged: (bool value) {
                            setState(() {
                              brandPrefer = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: brandPrefer,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            controller: brandController,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              hintText: "Nome da marca",
                              hintStyle: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  ButtonWidget(
                    onTap: () async => getResult(),
                    colorButton: Colors.black,
                    textButton: "QUAL PLACA?",
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
